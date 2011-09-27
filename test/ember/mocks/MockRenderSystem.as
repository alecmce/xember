package ember.mocks
{
	import ember.EntitySet;
	import ember.EntitySystem;

	import flash.display.BitmapData;
	
	public class MockRenderSystem
	{
		
		private var data:BitmapData;
		
		public var render:EntitySet;

		public function MockRenderSystem(system:EntitySystem)
		{
			render = system.getSet(MockRenderNode);
		}

		public function onRegister():void
		{
			
		}

		public function onRemove():void
		{
			// dummy
		}

		public function iterate():void
		{
			var node:MockRenderNode = render.head as MockRenderNode;
			while (node)
			{
				data.copyPixels(node.render.data, node.render.rect, node.spatial.position);
				node = node.next;
			}
		}


	}
}
