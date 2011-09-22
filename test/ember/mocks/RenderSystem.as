package ember.mocks
{
	import flash.display.BitmapData;
	
	public class RenderSystem
	{
		
		private var data:BitmapData;
		
		private var _head:RenderNode;

		public function RenderSystem()
		{
			
		}

		public function onRegister():void
		{
			// dummy
		}

		public function iterate():void
		{
			var node:RenderNode = _head;
			while (node)
			{
				data.copyPixels(node.render.data, node.render.rect, node.spatial.position);
				node = node.next as RenderNode;
			}
		}


	}
}
