package tomsbunnies.ctrl
{
	import ember.core.Ember;
	import org.robotlegs.mvcs.Command;
	import tomsbunnies.systems.BounceSystem;
	import tomsbunnies.systems.ProcessManager;
	import tomsbunnies.systems.RenderSystem;

	public class RegisterSystemsCommand extends Command
	{

		private var _ember:Ember;

		public function RegisterSystemsCommand(ember:Ember)
		{
			_ember = ember;
		}
		
		override public function execute():void
		{
			_ember.addSystem(RenderSystem);			
			_ember.addSystem(BounceSystem);
			_ember.addSystem(ProcessManager);
		}
		
	}
}
