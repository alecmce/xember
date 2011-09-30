package ember.io
{
	import ember.core.Entity;

	import mocks.MockPropertyComponent;
	import mocks.MockSpatialComponent;

	import org.osflash.signals.Signal;
	public class EntityEncoderTests
	{
		
		private var added:Signal;
		private var removed:Signal;
		private var encoder:EntityEncoder;
		
		[Before]
		public function before():void
		{
			added = new Signal();
			removed = new Signal();
			encoder = new EntityEncoder();
		}
		
		[After]
		public function after():void
		{
			encoder = null;
		}
		
		[Test]
		public function encoder_encodes_equivalent_entities_equivalently():void
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
			var ob:Object = encoder.encode(eb)
			
			CompareVOs.objectsAreEquivalent(oa, ob);
		}
		
	}
}
