package pong.ctrl
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;

	import ember.Entity;
	import ember.EntitySystem;

	import pong.attr.PhysicalAttribute;
	import pong.attr.RenderAttribute;
	import pong.sys.physics.PhysicsConfig;

	import flash.display.BitmapData;

	
	public class CreateCeilingCommand
	{
		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var config:PhysicsConfig;
		
		public function execute():void
		{
			var entity:Entity = system.createEntity();
			
			entity.addAttribute(generatePhysical());
			entity.addAttribute(generateRender());
		}

		private function generatePhysical():PhysicalAttribute
		{
			var toMeters:Number = config.toMeters;
			
			var def:b2BodyDef = new b2BodyDef();
			def.position.Set(400 * toMeters, 10 * toMeters);
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

		private function generateRender():RenderAttribute
		{
			var display:RenderAttribute = new RenderAttribute();
			display.data = new BitmapData(800, 20, false, 0xFF00FF00);
			display.rect = display.data.rect;
			
			return display;
		}
		
	}
}
