package pong.game.ctrl.setup
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import ember.core.Entity;
	import ember.core.EntitySystem;
	import flash.display.BitmapData;
	import pong.game.attr.PhysicalComponent;
	import pong.game.attr.PlayerComponent;
	import pong.game.attr.RenderComponent;
	import pong.game.sys.physics.PhysicsConfig;







	public class CreateLeftPaddleCommand
	{
		
		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var config:PhysicsConfig;
		
		public function execute():void
		{
			var entity:Entity = system.createEntity();
			
			entity.addComponent(generateControl());
			entity.addComponent(generatePhysical());
			entity.addComponent(generateRender());
		}

		private function generateControl():PlayerComponent
		{
			var player:PlayerComponent = new PlayerComponent();

			player.dx = 0;
			player.dy = 300 * config.toMeters;
			
			return player;
		}
		
		private function generatePhysical():PhysicalComponent
		{
			var toMeters:Number = config.toMeters;
			
			var def:b2BodyDef = new b2BodyDef();
			def.position.Set(40 * toMeters, 225 * toMeters);
			def.type = b2Body.b2_kinematicBody;
			def.allowSleep = false;
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(10 * toMeters, 75 * toMeters);

			var fixture:b2FixtureDef = new b2FixtureDef();
			fixture.shape = shape;
			fixture.density = 1.0;
			
			var physical:PhysicalComponent = new PhysicalComponent();
			physical.def = def;
			physical.fixture = fixture;
			
			return physical;
		}

		private function generateRender():RenderComponent
		{
			var display:RenderComponent = new RenderComponent();
			display.data = new BitmapData(20, 150, false, 0xFF1E90FF);
			display.rect = display.data.rect;
			display.offsetX = -10;
			display.offsetY = -75;
			
			return display;
		}
		
	}
}
