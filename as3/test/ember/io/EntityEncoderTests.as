package ember.io
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;

	import ember.core.Entity;
	import ember.core.EntitySystem;

	import mocks.MockPropertyComponent;
	import mocks.MockSpatialComponent;

	import org.osflash.signals.Signal;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	
	public class EntityEncoderTests
	{
		private static const TEST_NAME:String = "TestName";
		
		private var added:Signal;
		private var removed:Signal;
		private var encoder:EntityEncoder;
		
		[Before]
		public function before():void
		{
			var configFactory:ComponentConfigFactory = new ComponentConfigFactory();
			var componentEncoder:ComponentEncoder = new ComponentEncoder(configFactory);
			
			added = new Signal();
			removed = new Signal();
			encoder = new EntityEncoder(componentEncoder);
		}
		
		[After]
		public function after():void
		{
			encoder = null;
		}
		
		[Test]
		public function encodes_equivalent_entities_equivalently():void
		{
			var a:MockSpatialComponent = new MockSpatialComponent();
			a.x = 5;
			a.y = 10;

			var b:MockPropertyComponent = new MockPropertyComponent();
			b.url = "test.jpg";
			
			var ea:Entity = new Entity("", added, removed);
			ea.addComponent(a);
			ea.addComponent(b);
			
			var c:MockSpatialComponent = new MockSpatialComponent();
			c.x = 5;
			c.y = 10;

			var d:MockPropertyComponent = new MockPropertyComponent();
			d.url = "test.jpg";
			
			var eb:Entity = new Entity("", added, removed);
			eb.addComponent(c);
			eb.addComponent(d);

			var oa:Object = encoder.encode(ea);
			var ob:Object = encoder.encode(eb);
			
			assertTrue(CompareVOs.objectsAreEquivalent(oa, ob));
		}
		
		[Test]
		public function encodes_different_entities_differently():void
		{
			var a:MockSpatialComponent = new MockSpatialComponent();
			a.x = 6;
			a.y = 10;

			var b:MockPropertyComponent = new MockPropertyComponent();
			b.url = "test.jpg";
			
			var ea:Entity = new Entity("", added, removed);
			ea.addComponent(a);
			ea.addComponent(b);
			
			var c:MockSpatialComponent = new MockSpatialComponent();
			c.x = 5;
			c.y = 10;

			var d:MockPropertyComponent = new MockPropertyComponent();
			d.url = "test.jpg";
			
			var eb:Entity = new Entity("", added, removed);
			eb.addComponent(c);
			eb.addComponent(d);

			var oa:Object = encoder.encode(ea);
			var ob:Object = encoder.encode(eb);
			
			assertFalse(CompareVOs.objectsAreEquivalent(oa, ob));
		}
		
		[Test]
		public function decode_reverses_encode():void
		{
			var a:MockSpatialComponent = new MockSpatialComponent();
			a.x = 5;
			a.y = 10;

			var b:MockPropertyComponent = new MockPropertyComponent();
			b.url = "test.jpg";
			
			var entity:Entity = new Entity("", added, removed);
			entity.addComponent(a);
			entity.addComponent(b);

			var encoded:Object = encoder.encode(entity);
			
			var system:EntitySystem = new EntitySystem(new SwiftSuspendersInjector());

			var roundtrip:Entity = encoder.decode(system, encoded);
			var c:MockSpatialComponent = roundtrip.getComponent(MockSpatialComponent) as MockSpatialComponent;
			var d:MockPropertyComponent = roundtrip.getComponent(MockPropertyComponent) as MockPropertyComponent;
			
			assertTrue(roundtrip.hasComponent(MockSpatialComponent));
			assertTrue(roundtrip.hasComponent(MockPropertyComponent));
			assertTrue(CompareVOs.objectsAreEquivalent(a, c));
			assertTrue(CompareVOs.objectsAreEquivalent(b, d));
		}

		[Test]
		public function encoding_roundtrip_preserves_naming():void
		{
			var entity:Entity = new Entity(TEST_NAME, added, removed);
			var object:Object = encoder.encode(entity);
			
			var system:EntitySystem = new EntitySystem(new SwiftSuspendersInjector());
			var roundtrip:Entity = encoder.decode(system, object);
			
			assertEquals(TEST_NAME, roundtrip.name);
		}
	}
}
