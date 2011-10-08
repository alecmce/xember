package tomsbunnies.systems
{
	import ember.core.Ember;
	import ember.core.Nodes;

	import tomsbunnies.components.GraphicComponent;
	import tomsbunnies.events.Render;
	import tomsbunnies.systems.nodes.RendererNode;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	public class RenderSystem
	{
		private const MIN_X:int = 0;
		private const MAX_X:int = 640;
		private const MIN_Y:int = 0;
		private const MAX_Y:int = 480;
		
		private const BLANK_RECT:Rectangle = new Rectangle(MIN_X, MIN_Y, MAX_X, MAX_Y);

		private var _ember:Ember;
		private var _root:DisplayObjectContainer;
		private var _render:Render;

		private var _bitmap:Bitmap;
		private var _buffer:BitmapData;
		
		private var _nodes:Nodes;

		public function RenderSystem(ember:Ember, root:DisplayObjectContainer, render:Render)
		{
			_ember = ember;
			_root = root;
			_render = render;
		}
		
		public function onRegister():void
		{
			_buffer = new BitmapData(MAX_X, MAX_Y, false, 0xFFFFFF);
			_bitmap = new Bitmap(_buffer);
			_root.addChild(_bitmap);
			_render.add(onRender);
			
			_nodes = _ember.getNodes(RendererNode);
		}

		public function onRender():void
		{
			_buffer.lock();
			_buffer.fillRect(BLANK_RECT, 0xFFFFCC);
			
			var node:RendererNode;
			for (node = _nodes.head; node; node = node.next)
			{
				var graphic:GraphicComponent = node.graphic;
				_buffer.copyPixels(graphic.asset, graphic.rect, node.spatial.position, null, null, true);
			}
			
			_buffer.unlock();
		}

		public function onRemove():void
		{
			_root.removeChild(_bitmap);
			_buffer.dispose();
			_buffer = null;
			_bitmap = null;
		}
	}
}