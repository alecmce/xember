package pong.ctrl
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;

	import ember.Entity;
	import ember.EntitySystem;

	import pong.attr.PhysicalAttribute;
	import pong.attr.PlayerAttribute;
	import pong.attr.RenderAttribute;
	import pong.sys.physics.PhysicsConfig;

	import flash.display.BitmapData;

	public class CreateLeftPaddleCommand
	{
		
		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var config:PhysicsConfig;
		
		public function execute():void
		{
			var entity:Entity = system.createEntity();
			
			entity.addAttribute(generateControl());
			entity.addAttribute(generatePhysical());
			entity.addAttribute(generateRender());
		}

		private function generateControl():PlayerAttribute
		{
			var player:PlayerAttribute = new PlayerAttribute();

			player.dx = 0;
			player.dy = 200 * config.toMeters;
			
			return player;
		}

		private function generatePhysical():PhysicalAttribute
		{
			var toMeters:Number = config.toMeters;
			
			var def:b2BodyDef = new b2BodyDef();
			def.position.Set(40 * toMeters, 225 * toMeters);
			def.type = b2Body.b2_kinematicBody;
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(10 * toMeters, 75 * toMeters);

			var fixture:b2FixtureDef = new b2FixtureDef();
			fixture.shape = shape;
			fixture.density = 1.0;
			
			var physical:PhysicalAttribute = new PhysicalAttribute();
			physical.def = def;
			physical.fixture = fixture;
			
			return physical;
		}

		private function generateRender():RenderAttribute
		{
			var display:RenderAttribute = new RenderAttribute();
			display.data = new BitmapData(30, 150, false, 0xFF1E90FF);
			display.rect = display.data.rect;
			
			return display;
		}
		
	}
}
