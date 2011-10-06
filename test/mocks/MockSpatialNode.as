package mocks
{
	import ember.core.Entity;
	
	public class MockSpatialNode
	{
		public var prev:MockSpatialNode;
		public var next:MockSpatialNode;
		
		public var entity:Entity;
		
		[Ember(required)]
		public var spatial:MockSpatialComponent;
	}
}
