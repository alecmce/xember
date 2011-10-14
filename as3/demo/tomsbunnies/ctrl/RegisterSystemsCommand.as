package tomsbunnies.ctrl
{
	import ember.core.Game;
	import org.robotlegs.mvcs.Command;
	import tomsbunnies.systems.BounceSystem;
	import tomsbunnies.systems.ProcessManager;
	import tomsbunnies.systems.RenderSystem;

	public class RegisterSystemsCommand extends Command
	{

		private var _game:Game;

		public function RegisterSystemsCommand(game:Game)
		{
			_game = game;
		}
		
		override public function execute():void
		{
			_game.addSystem(RenderSystem);			
			_game.addSystem(BounceSystem);
			_game.addSystem(ProcessManager);
		}
		
	}
}
