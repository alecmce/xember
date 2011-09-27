package tomsbunnies.ctrl
{
	import ember.EntitySystem;

	import tomsbunnies.systems.BounceSystem;
	import tomsbunnies.systems.ProcessManager;
	import tomsbunnies.systems.RenderSystem;

	import org.robotlegs.mvcs.Command;
	
	public class RegisterSystemsCommand extends Command
	{

		private var _system:EntitySystem;

		public function RegisterSystemsCommand(sytem:EntitySystem)
		{
			_system = sytem;
		}
		
		override public function execute():void
		{
			_system.addSystem(RenderSystem);			
			_system.addSystem(BounceSystem);
			_system.addSystem(ProcessManager);
		}
		
	}
}
