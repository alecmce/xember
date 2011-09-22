package pong.ctrl
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;

	import pong.sys.physics.PhysicsConfig;
	
	public class CreatePhysicsCommand
	{
		
		[Inject]
		public var config:PhysicsConfig;

		public function execute():void
		{
			var gravity:b2Vec2 = new b2Vec2(0, 0);
			config.world = new b2World(gravity, true);
		}
		
	}
}
