package pong.game.ctrl.setup
{
	import ember.core.Game;

	import pong.game.sys.ai.AISystem;
	import pong.game.sys.physics.PhysicsSystem;
	import pong.game.sys.player.PlayerSystem;
	import pong.game.sys.render.SimpleBlitterRenderSystem;

	
	public class ConfigureSystemsCommand
	{
		private var _game:Game;

		public function ConfigureSystemsCommand(game:Game)
		{
			_game = game;
		}

		public function execute():void
		{
			_game.addSystem(PhysicsSystem);
//			_ember.addSystem(RenderPhysicsSystem);
			_game.addSystem(SimpleBlitterRenderSystem);
			_game.addSystem(AISystem);
			_game.addSystem(PlayerSystem);
		}
		
	}
}
