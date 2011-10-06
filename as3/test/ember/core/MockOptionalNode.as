package ember.core
{
	import mocks.MockRenderComponent;
	import mocks.MockSpatialComponent;
	
	public class MockOptionalNode
	{
		
		public var prev:MockOptionalNode;
		public var next:MockOptionalNode;
		
		[Ember(required)]
		public var spatial:MockSpatialComponent;
		
		[Ember(optional)]
		public var render:MockRenderComponent;
		
	}
}
