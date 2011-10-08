package mocks
{
	public class MockOptionalNode
	{
		public var prev:MockOptionalNode;
		public var next:MockOptionalNode;
		
		[Ember(required)]
		public var required:MockComponent;
		
		[Ember(optional)]
		public var optional:MockOptionalComponent;
		
		public var ignored:MockIgnoredComponent;
	}
}
