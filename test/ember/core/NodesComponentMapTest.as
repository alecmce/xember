package ember.core
{
	import asunit.asserts.assertSame;

	import mocks.MockRenderComponent;
	
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
			components.add("render", MockRenderComponent);
			
			_map.add(components, nodes);
			assertSame(nodes, _map.getNodesFor(MockRenderComponent)[0]);
		}
		
	}
}
