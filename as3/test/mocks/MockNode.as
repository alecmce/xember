package mocks
{
	import ember.core.Entity;
	
	public class MockNode
	{
		public var entity:Entity;
		
		public var prev:MockNode;
		public var next:MockNode;
		
		[Ember(required)]
		public var required:MockComponent;
	}
}
