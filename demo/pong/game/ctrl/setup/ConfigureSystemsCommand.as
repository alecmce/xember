package pong.game.ctrl.setup
{
	import ember.EntitySystem;
	import pong.game.sys.ai.AINode;
	import pong.game.sys.ai.AISystem;
	import pong.game.sys.physics.PhysicsNode;
	import pong.game.sys.physics.PhysicsSystem;
	import pong.game.sys.physics.RenderPhysicsSystem;
	import pong.game.sys.player.PlayerNode;
	import pong.game.sys.player.PlayerSystem;
	
	public class ConfigureSystemsCommand
	{
		
		[Inject]
		public var system:EntitySystem;

		public function execute():void
		{
			system.addSystem(PhysicsSystem, PhysicsNode);
			system.addSystem(RenderPhysicsSystem, PhysicsNode);
			system.addSystem(PlayerSystem, PlayerNode);
			system.addSystem(AISystem, AINode);
		}
		
	}
}
