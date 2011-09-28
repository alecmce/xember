package pong.game.sys.render
{
	import Box2D.Common.Math.b2Vec2;

	import ember.EntitySystem;
	import ember.Nodes;

	import pong.game.Tick;
	import pong.game.attr.RenderComponent;
	import pong.game.sys.physics.PhysicsConfig;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	public class SimpleBlitterRenderSystem
	{
		
		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var tick:Tick;
		
		[Inject]
		public var config:PhysicsConfig;
		
		[Inject]
		public var view:DisplayObjectContainer;
		
		private var _data:BitmapData;
		
		private var _dest:Point;
		private var toPixels:Number;
		
		private var _nodes:Nodes;
		private var _bitmap:Bitmap;

		public function onRegister():void
		{
			_data = new BitmapData(800, 600, true, 0xFFFFFFFF);
			_dest = new Point();
			_bitmap = new Bitmap(_data);
			view.addChild(_bitmap);
			
			tick.add(iterate);
			toPixels = config.toPixels;
			
			_nodes = system.getNodes(RenderNode);
		}
		
		public function onRemove():void
		{
			tick.remove(iterate);
			
			view.removeChild(_bitmap);
			_bitmap = null;
			_dest = null;
			
			_data.dispose();
			_data = null;
		}
		
		private function iterate():void
		{
			_data.lock();
			_data.fillRect(_data.rect, 0);
			
			for (var node:RenderNode = _nodes.head; node; node = node.next)
			{
				var render:RenderComponent = node.render;
				var position:b2Vec2 = node.physical.body.GetPosition();
				
				_dest.x = (position.x * toPixels) + render.offsetX;
				_dest.y = (position.y * toPixels) + render.offsetY;
				
				_data.copyPixels(render.data, render.rect, _dest);
			}
			
			_data.unlock();
		}
		
	}
}
