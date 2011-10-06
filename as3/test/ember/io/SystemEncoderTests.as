package ember.io
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;

	import ember.core.Entity;
	import ember.core.EntitySystem;

	import mocks.MockSpatialComponent;

	import org.robotlegs.adapters.SwiftSuspendersInjector;
	
	public class SystemEncoderTests
	{
		private var encoder:SystemEncoder;
		
		private var injector:SwiftSuspendersInjector;
		
		[Before]
		public function before():void
		{
			var configFactory:ComponentConfigFactory = new ComponentConfigFactory();
			var componentEncoder:ComponentEncoder = new ComponentEncoder(configFactory);
			var entityEncoder:EntityEncoder = new EntityEncoder(componentEncoder);
			encoder = new SystemEncoder(entityEncoder);
			
			injector = new SwiftSuspendersInjector();
		}
		
		[After]
		public function after():void
		{
			encoder = null;
		}
		
		[Test]
		public function encodes_similar_systems_identically():void
		{
			var a:EntitySystem = new EntitySystem(injector);
			var ae:Entity = a.createEntity();

			var ac:MockSpatialComponent = new MockSpatialComponent();
			ac.x = 5;
			ac.y = 10;
			ae.addComponent(ac);
			
			var b:EntitySystem = new EntitySystem(injector);
			var be:Entity = b.createEntity();

			var bc:MockSpatialComponent = new MockSpatialComponent();
			bc.x = 5;
			bc.y = 10;
			be.addComponent(bc);

			var ao:Object = encoder.encode(a);
			var bo:Object = encoder.encode(b);
			assertTrue(CompareVOs.objectsAreEquivalent(ao, bo));
		}
		
		[Test]
		public function encodes_different_systems_differently():void
		{
			var a:EntitySystem = new EntitySystem(injector);
			var ae:Entity = a.createEntity();

			var ac:MockSpatialComponent = new MockSpatialComponent();
			ac.x = 5;
			ac.y = 10;
			ae.addComponent(ac);
			
			var b:EntitySystem = new EntitySystem(injector);
			var be:Entity = b.createEntity();

			var bc:MockSpatialComponent = new MockSpatialComponent();
			bc.x = 6;
			bc.y = 10;
			be.addComponent(bc);

			var ao:Object = encoder.encode(a);
			var bo:Object = encoder.encode(b);
			assertFalse(CompareVOs.objectsAreEquivalent(ao, bo));
		}
		
		[Test]
		public function encode_and_decode_roundtrips():void
		{
			var a:EntitySystem = new EntitySystem(injector);
			a.createEntity();
			a.createEntity();
			a.createEntity();
			a.createEntity();

			var encoded:Object = encoder.encode(a);

			var b:EntitySystem = new EntitySystem(injector);
			encoder.decode(b, encoded);
			
			assertEquals(4, b.getEntities().length);
		}
		
	}
}
