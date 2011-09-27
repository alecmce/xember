package ember.mocks
{
	import ember.Entity;
	
	public class MockRenderNode
	{
		public var entity:Entity;
		
		public var prev:MockRenderNode;
		public var next:MockRenderNode;
		
		public var spatial:MockSpatialComponent;
		public var render:MockRenderComponent;

	}
}
