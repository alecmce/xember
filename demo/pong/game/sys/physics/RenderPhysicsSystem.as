package pong.game.sys.physics
{
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;

	import alecmce.time.Time;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class RenderPhysicsSystem
	{
		
		[Inject]
		public var time:Time;
		
		[Inject]
		public var config:PhysicsConfig;
		
		[Inject]
		public var view:DisplayObjectContainer;
		
		private var world:b2World;
		private var debugDraw:b2DebugDraw;
		
		public function onRegister():void
		{
			debugDraw = generateDebugDraw();
			
			world = config.world;
			world.SetDebugDraw(debugDraw);
			
			view.addChild(debugDraw.GetSprite());
			
			time.tick.add(iterate);
		}
		
		public function onRemove():void
		{
			time.tick.remove(iterate);
			
			view.removeChild(debugDraw.GetSprite());
		}
		
		private function iterate(time:uint):void
		{
			world.DrawDebugData();
		}

		private function generateDebugDraw():b2DebugDraw
		{
			var draw:b2DebugDraw = new b2DebugDraw();
			draw.SetSprite(new Sprite());
			draw.SetDrawScale(config.toPixels);
			draw.SetFlags(b2DebugDraw.e_shapeBit);
			draw.SetLineThickness(2);
			
			return draw;
		}
		
	}	
}
