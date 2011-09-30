package ember.io
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;

	import mocks.MockSpatialComponent;
	
	public class ComponentEncoderTests
	{
		private var encoder:ComponentEncoder;
		
		[Before]
		public function before():void
		{
			encoder = new ComponentEncoder();
		}
		
		[After]
		public function after():void
		{
			encoder = null;
		}
		
		[Test]
		public function encodes_equivalent_components_equivalently():void
		{
			var componentA:MockSpatialComponent = new MockSpatialComponent();
			componentA.x = 5;
			componentA.y = 10;
			
			var componentB:MockSpatialComponent = new MockSpatialComponent();
			componentB.x = 5;
			componentB.y = 10;
			
			var a:Object = encoder.encode(componentA);
			var b:Object = encoder.encode(componentB);
			assertTrue(CompareVOs.objectsAreEquivalent(a, b));
		}
		
		[Test]
		public function encodes_differentiable_components_unequivalently():void
		{
			var componentA:MockSpatialComponent = new MockSpatialComponent();
			componentA.x = 5;
			componentA.y = 10;
			
			var componentB:MockSpatialComponent = new MockSpatialComponent();
			componentB.x = 6;
			componentB.y = 10;
			
			var a:Object = encoder.encode(componentA);
			var b:Object = encoder.encode(componentB);
			assertFalse(CompareVOs.objectsAreEquivalent(a, b));
		}
		
	}
	
}
