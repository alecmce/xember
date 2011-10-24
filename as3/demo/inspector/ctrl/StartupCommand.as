package inspector.ctrl
{
	import ember.core.Ember;

	import inspector.prefab.BallFactory;
	import inspector.systems.LoopSystem;
	import inspector.systems.PositionSystem;
	import inspector.systems.RenderSystem;
	
	public class StartupCommand
	{
		private static const COUNT:int = 20;
		
		private var _ember:Ember;
		private var _balls:BallFactory;
		
		public function StartupCommand(ember:Ember, balls:BallFactory)
		{
			_ember = ember;
			_balls = balls;
		}

		public function execute():void
		{
			for (var i:int = 0; i < COUNT; i++)
				_balls.create();
			
			_ember.addSystem(PositionSystem);
			_ember.addSystem(RenderSystem);
			_ember.addSystem(LoopSystem);
		}
		
	}
}
