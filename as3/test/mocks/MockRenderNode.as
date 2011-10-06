package mocks
{
	import ember.core.Entity;
	
	public class MockRenderNode
	{
		public var entity:Entity;
		
		public var prev:MockRenderNode;
		public var next:MockRenderNode;
		
		[Ember(required)]
		public var spatial:MockSpatialComponent;
		
		[Ember(required)]
		public var render:MockRenderComponent;

		[Ember(optional)]
		public var other:MockPropertyComponent;

	}
}
