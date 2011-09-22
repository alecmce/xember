package pong.game.ctrl.setup
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;

	import ember.Entity;
	import ember.EntitySystem;

	import pong.game.Names;
	import pong.game.attr.PhysicalAttribute;
	import pong.game.sys.physics.PhysicsConfig;

	public class CreateLeftSensorCommand
	{
		private var _system:EntitySystem;
		private var _config:PhysicsConfig;
		
		public function CreateLeftSensorCommand(system:EntitySystem, config:PhysicsConfig)
		{
			_system = system;
			_config = config;
		}
		
		public function execute():void
		{
			var entity:Entity = _system.createEntity();
			
			entity.addAttribute(generatePhysical());
		}

		private function generatePhysical():PhysicalAttribute
		{
			var toMeters:Number = _config.toMeters;
			
			var def:b2BodyDef = new b2BodyDef();
			def.position.Set(-5 * toMeters, 300 * toMeters);
			def.type = b2Body.b2_staticBody;
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(10 * toMeters, 300 * toMeters);
			
			var fixture:b2FixtureDef = new b2FixtureDef();
			fixture.shape = shape;
			fixture.isSensor = true;
			fixture.userData = Names.LEFT;
			
			var physical:PhysicalAttribute = new PhysicalAttribute();
			physical.def = def;
			physical.fixture = fixture;
			
			return physical;
		}
		
	}
}
