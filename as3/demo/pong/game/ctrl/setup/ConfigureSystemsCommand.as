package pong.game.ctrl.setup
{
	import ember.core.Ember;

	import pong.game.sys.ai.AISystem;
	import pong.game.sys.physics.PhysicsSystem;
	import pong.game.sys.player.PlayerSystem;
	import pong.game.sys.render.SimpleBlitterRenderSystem;

	
	public class ConfigureSystemsCommand
	{
		private var _ember:Ember;

		public function ConfigureSystemsCommand(ember:Ember)
		{
			_ember = ember;
		}

		public function execute():void
		{
			_ember.addSystem(PhysicsSystem);
//			_ember.addSystem(RenderPhysicsSystem);
			_ember.addSystem(SimpleBlitterRenderSystem);
			_ember.addSystem(AISystem);
			_ember.addSystem(PlayerSystem);
		}
		
	}
}
