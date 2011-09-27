package pong.game.ctrl.setup
{
	import ember.EntitySystem;

	import pong.game.sys.ai.AISystem;
	import pong.game.sys.physics.PhysicsSystem;
	import pong.game.sys.player.PlayerSystem;
	import pong.game.sys.render.SimpleBlitterRenderSystem;
	
	public class ConfigureSystemsCommand
	{
		[Inject]
		public var system:EntitySystem;

		public function execute():void
		{
			system.addSystem(PhysicsSystem);
//			system.addSystem(RenderPhysicsSystem);
			system.addSystem(SimpleBlitterRenderSystem);
			system.addSystem(AISystem);
			system.addSystem(PlayerSystem);
		}
		
	}
}
