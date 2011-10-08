package tomsbunnies
{
	import ember.core.Ember;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.mvcs.Context;
	import tomsbunnies.ctrl.CreateBunniesCommand;
	import tomsbunnies.ctrl.RegisterSystemsCommand;
	import tomsbunnies.events.Pause;
	import tomsbunnies.events.Render;
	import tomsbunnies.events.Tick;



	
	public class TomsBunniesContext extends Context
	{
		
		public function TomsBunniesContext(root:DisplayObjectContainer)
		{
			super(root);
		}
		
		override public function startup():void
		{
			injector.mapSingleton(Tick);
			injector.mapSingleton(Render);
			injector.mapSingleton(Pause);
			
			injector.mapSingleton(Ember);
			
			commandMap.execute(CreateBunniesCommand);
			commandMap.execute(RegisterSystemsCommand);
		}
		
	}
}