package pong.game.ctrl.setup
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;

	import pong.game.sys.physics.ContactListener;
	import pong.game.sys.physics.PhysicsConfig;

	import flash.events.IEventDispatcher;

	
	public class CreatePhysicsCommand
	{
		
		[Inject]
		public var config:PhysicsConfig;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;

		public function execute():void
		{
			var gravity:b2Vec2 = new b2Vec2(0, 0);
			var world:b2World = new b2World(gravity, true);

			var contacts:ContactListener = new ContactListener(eventDispatcher);
			world.SetContactListener(contacts);
			
			config.world = world;
		}
		
	}
}
