package pong.sys.render
{
	import Box2D.Common.Math.b2Vec2;

	import alecmce.time.Time;

	import ember.EntitySet;

	import pong.attr.RenderAttribute;
	import pong.sys.physics.PhysicsConfig;

	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class SimpleBlitterRenderSystem
	{
		
		[Inject]
		public var nodes:EntitySet;

		[Inject]
		public var time:Time;
		
		[Inject]
		public var config:PhysicsConfig;
		
		[Inject]
		public var data:BitmapData;
		
		private var dest:Point;
		private var toPixels:Number;
		
		public function SimpleBlitterRenderSystem() 
		{
			dest = new Point();
		}
		
		public function onRegister():void
		{
			time.tick.add(iterate);
			toPixels = config.toPixels;
		}
		
		public function onRemove():void
		{
			time.tick.remove(iterate);
		}
		
		private function iterate(time:uint):void
		{
			data.lock();
			data.fillRect(data.rect, 0);
			
			var node:RenderNode = nodes.head as RenderNode;
			while (node)
			{
				var render:RenderAttribute = node.render;
				var position:b2Vec2 = node.physical.body.GetPosition();
				
				dest.x = (position.x * toPixels) + render.offsetX;
				dest.y = (position.y * toPixels) + render.offsetY;
				
				data.copyPixels(render.data, render.rect, dest);
				
				node = node.next as RenderNode;
			}
			
			data.unlock();
		}
		
	}
}
