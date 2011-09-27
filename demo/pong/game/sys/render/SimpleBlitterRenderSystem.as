package pong.game.sys.render
{
	import Box2D.Common.Math.b2Vec2;

	import alecmce.time.Time;

	import ember.Nodes;
	import ember.EntitySystem;

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
		public var time:Time;
		
		[Inject]
		public var config:PhysicsConfig;
		
		[Inject]
		public var view:DisplayObjectContainer;
		
		private var data:BitmapData;
		
		private var dest:Point;
		private var toPixels:Number;
		
		private var _nodes:Nodes;

		public function onRegister():void
		{
			data = new BitmapData(800, 600, true, 0xFFFFFFFF);
			dest = new Point();
			view.addChild(new Bitmap(data));
			
			time.tick.add(iterate);
			toPixels = config.toPixels;
			
			_nodes = system.getSet(RenderNode);
		}
		
		public function onRemove():void
		{
			time.tick.remove(iterate);
		}
		
		private function iterate(time:uint):void
		{
			data.lock();
			data.fillRect(data.rect, 0);
			
			for (var node:RenderNode = _nodes.head; node; node = node.next)
			{
				var render:RenderComponent = node.render;
				var position:b2Vec2 = node.physical.body.GetPosition();
				
				dest.x = (position.x * toPixels) + render.offsetX;
				dest.y = (position.y * toPixels) + render.offsetY;
				
				data.copyPixels(render.data, render.rect, dest);
			}
			
			data.unlock();
		}
		
	}
}
