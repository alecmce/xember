package inspector.systems
{
	import ember.core.Ember;
	import ember.core.Nodes;

	import inspector.LoopSignals;
	import inspector.components.RenderComponent;
	import inspector.components.SpatialComponent;
	import inspector.systems.nodes.RenderNode;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class RenderSystem
	{
		private var _root:DisplayObjectContainer;
		private var _ember:Ember;
		private var _loop:LoopSignals;
		private var _point:Point;

		private var _bitmapData:BitmapData;
		private var _bitmap:Bitmap;
		private var _rect:Rectangle;
		
		private var _nodes:Nodes;

		public function RenderSystem(root:DisplayObjectContainer, ember:Ember, loop:LoopSignals)
		{
			_root = root;
			_ember = ember;
			_loop = loop;
			_point = new Point();
		}

		public function onRegister():void
		{
			_nodes = _ember.getNodes(RenderNode);
			_loop.update.add(iterate);

			var stage:Stage = _root.stage;
			_bitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0);
			_bitmap = new Bitmap(_bitmapData);
			_root.addChild(_bitmap);
			_rect = _bitmapData.rect;
		}

		public function onRemove():void
		{
			_root.removeChild(_bitmap);
			_bitmapData.dispose();
			
			_loop.update.remove(iterate);
		}

		private function iterate(time:uint, dt:uint):void
		{
			_bitmapData.lock();
			_bitmapData.fillRect(_rect, 0);
			
			for (var node:RenderNode = _nodes.head as RenderNode; node; node = node.next)
			{
				var render:RenderComponent = node.render;
				var spatial:SpatialComponent = node.spatial;
				
				var data:BitmapData = render.data;
				_point.x = spatial.x - spatial.radius;
				_point.y = spatial.y - spatial.radius;
				
				_bitmapData.copyPixels(data, data.rect, _point, null, null, true);
			}
			
			_bitmapData.unlock();
		}
	}
}
