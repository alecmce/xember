package ember.mocks
{
	import flash.display.BitmapData;
	
	public class MockRenderSystem
	{
		
		private var data:BitmapData;
		
		private var _head:MockRenderNode;

		public function MockRenderSystem()
		{
			
		}

		public function onRegister():void
		{
			// dummy
		}

		public function iterate():void
		{
			var node:MockRenderNode = _head;
			while (node)
			{
				data.copyPixels(node.render.data, node.render.rect, node.spatial.position);
				node = node.next as MockRenderNode;
			}
		}


	}
}
