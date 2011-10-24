package inspector
{
	import ember.core.Ember;

	import inspector.ctrl.StartupCommand;
	import inspector.prefab.BallFactory;
	import inspector.util.Random;
	import inspector.util.RandomColors;

	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	public class InspectorContext extends Context
	{
		public function InspectorContext(root:DisplayObjectContainer)
		{
			super(root);
		}

		override public function startup():void
		{
			injector.mapSingleton(Random);
			injector.mapSingleton(RandomColors);
			injector.mapSingleton(LoopSignals);
			
			injector.mapSingleton(BallFactory);
			
			injector.mapSingleton(Ember);
			
			commandMap.execute(StartupCommand);
		}
		
	}
}
