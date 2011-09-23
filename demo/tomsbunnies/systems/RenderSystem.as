package tomsbunnies.systems
{
	import ember.EntitySet;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import tomsbunnies.components.GraphicComponent;
	import tomsbunnies.events.Render;
	import tomsbunnies.systems.nodes.RendererNode;



	public class RenderSystem
	{
		private const BLANK_RECT:Rectangle = new Rectangle(_minX, _minY, _maxX, _maxY);

		[Inject]
		public var entities:EntitySet;

		[Inject]
		public var contextView:DisplayObjectContainer;

		[Inject]
		public var render:Render;

		private const _maxX:int = 640;
		private const _minX:int = 0;
		private const _maxY:int = 480;
		private const _minY:int = 0;

		private var _bitmap:Bitmap;
		private var _buffer:BitmapData;

		public function onRegister():void
		{
			_buffer = new BitmapData(_maxX, _maxY, false, 0xFFFFFF);
			_bitmap = new Bitmap(_buffer);
			contextView.addChild(_bitmap);
			render.add(onRender);
		}

		public function onRender():void
		{
			_buffer.lock();
			_buffer.fillRect(BLANK_RECT, 0xFFFFCC);
			
			var node:RendererNode;
			for (node = entities.head as RendererNode; node; node = node.next as RendererNode)
			{
				var graphic:GraphicComponent = node.graphic;
				_buffer.copyPixels(graphic.asset, graphic.rect, node.spatial.position, null, null, true);
			}
			
			_buffer.unlock();
		}

		public function onRemove():void
		{
			contextView.removeChild(_bitmap);
			_buffer.dispose();
			_buffer = null;
			_bitmap = null;
		}
	}
}