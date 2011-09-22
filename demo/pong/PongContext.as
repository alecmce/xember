package pong
{
	import alecmce.time.SimpleTime;
	import alecmce.time.Time;

	import ember.EntitySystem;

	import pong.ctrl.ConfigureSystemsCommand;
	import pong.ctrl.CreateBallCommand;
	import pong.ctrl.CreateCeilingCommand;
	import pong.ctrl.CreateFloorCommand;
	import pong.ctrl.CreateLeftPaddleCommand;
	import pong.ctrl.CreatePhysicsCommand;
	import pong.ctrl.CreateRightPaddleCommand;
	import pong.sys.physics.PhysicsConfig;

	import org.robotlegs.mvcs.Context;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	
	public class PongContext extends Context
	{
		public function PongContext(contextView:DisplayObjectContainer)
		{
			super(contextView, true);
		}
		
		override public function startup():void
		{
			var system:EntitySystem = new EntitySystem(injector);
			
			var root:BitmapData = new BitmapData(800, 600, true, 0xFFFFFFFF);
			contextView.addChild(new Bitmap(root));
			injector.mapValue(BitmapData, root);
			
			injector.mapSingleton(PhysicsConfig);
			injector.mapSingletonOf(Time, SimpleTime);
			injector.mapValue(EntitySystem, system);
			
			commandMap.execute(CreatePhysicsCommand);
			commandMap.execute(CreateFloorCommand);
			commandMap.execute(CreateCeilingCommand);
			commandMap.execute(CreateLeftPaddleCommand);
			commandMap.execute(CreateRightPaddleCommand);
			commandMap.execute(CreateBallCommand);
			commandMap.execute(ConfigureSystemsCommand);
		}
		
	}
}
