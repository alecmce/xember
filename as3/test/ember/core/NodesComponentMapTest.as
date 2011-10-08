package ember.core
{
	import mocks.MockComponent;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.hasItem;
	
	public class NodesComponentMapTest
	{
		private var _map:NodesComponentMap;
		
		[Before]
		public function before():void
		{
			_map = new NodesComponentMap();
		}
		
		[After]
		public function after():void
		{
			_map = null;
		}
		
		[Test]
		public function can_reference_nodes_through_map():void
		{
			var nodes:Nodes = new Nodes(null, null);
			
			var components:NodeConfigComponentsList = new NodeConfigComponentsList();
			components.add("render", MockComponent);
			
			_map.add(components, nodes);
			
			assertThat(_map.getNodesFor(MockComponent), hasItem(nodes));
		}
		
	}
}
