package pong.ctrl
{
	import ember.EntitySystem;

	import pong.sys.ai.AINode;
	import pong.sys.ai.AISystem;
	import pong.sys.physics.PhysicsNode;
	import pong.sys.physics.PhysicsSystem;
	import pong.sys.physics.RenderPhysicsSystem;
	import pong.sys.player.PlayerNode;
	import pong.sys.player.PlayerSystem;


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
