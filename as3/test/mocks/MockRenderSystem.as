package mocks
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	
	public class MockRenderSystem
	{
		
		private var _nodes:Nodes;

		public function MockRenderSystem(system:EntitySystem)
		{
			_nodes = system.getNodes(MockRenderNode);
		}

		public function onRegister():void
		{
			// dummy
		}

		public function onRemove():void
		{
			// dummy
		}

		public function iterate():void
		{
			for (var node:MockRenderNode = _nodes.head as MockRenderNode; node; node = node.next)
			{
				// dummy
			}
		}


	}
}
