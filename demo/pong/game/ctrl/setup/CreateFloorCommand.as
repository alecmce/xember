package pong.game.ctrl.setup
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;

	import ember.Entity;
	import ember.EntitySystem;

	import pong.game.attr.PhysicalAttribute;
	import pong.game.sys.physics.PhysicsConfig;
	
	public class CreateFloorCommand
	{
		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var config:PhysicsConfig;
		
		public function execute():void
		{
			var entity:Entity = system.createEntity();
			
			entity.addAttribute(generatePhysical());
		}

		private function generatePhysical():PhysicalAttribute
		{
			var toMeters:Number = config.toMeters;
			
			var def:b2BodyDef = new b2BodyDef();
			def.position.Set(400 * toMeters, 590 * toMeters);
			def.type = b2Body.b2_staticBody;
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(400 * toMeters, 10 * toMeters);

			var fixture:b2FixtureDef = new b2FixtureDef();
			fixture.shape = shape;
			fixture.density = 0.0;
			fixture.friction = 0;
			
			var physical:PhysicalAttribute = new PhysicalAttribute();
			physical.def = def;
			physical.fixture = fixture;
			
			return physical;
		}
	}
}
