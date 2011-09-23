package pong.game.ctrl.setup
{
	import ember.EntitySystem;

	import pong.game.sys.ai.AINode;
	import pong.game.sys.ai.AISystem;
	import pong.game.sys.physics.PhysicsNode;
	import pong.game.sys.physics.PhysicsSystem;
	import pong.game.sys.player.PlayerNode;
	import pong.game.sys.player.PlayerSystem;
	import pong.game.sys.render.RenderNode;
	import pong.game.sys.render.SimpleBlitterRenderSystem;
	
	public class ConfigureSystemsCommand
	{
		[Inject]
		public var system:EntitySystem;

		public function execute():void
		{
			system.addSystem(PhysicsSystem, PhysicsNode);
//			system.addSystem(RenderPhysicsSystem, PhysicsNode);
			system.addSystem(SimpleBlitterRenderSystem, RenderNode);
			system.addSystem(AISystem, AINode);
			system.addSystem(PlayerSystem, PlayerNode);
		}
		
	}
}
