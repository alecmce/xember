package ember.core
{
	import ember.core.ds.AllDSTests;
	import ember.core.ds.InheritanceTreeTests;
	
	[Suite]
	public class AllCoreTests
	{
		public var ds:AllDSTests;
		
		public var inheritanceTreeTests:InheritanceTreeTests;
		public var componentTypeTests:ComponentMaskFactoryTests;
		public var emberTests:GameTests;
		public var entitiesTests:EntitiesTests;
		public var entityTests:EntityTests;
		public var nodesComponentMapTests:NodesComponentMapTests;
		public var nodesConfigTests:NodesConfigTests;
		public var nodesFactoryTests:NodesFactoryTests;
		public var nodesManagerTests:NodesManagerTests;
		public var systemTests:SystemsTests;
		
	}
}
