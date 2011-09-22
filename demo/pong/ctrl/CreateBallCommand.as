package pong.ctrl
{
	import pong.Names;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;

	import ember.Entity;
	import ember.EntitySystem;

	import pong.attr.PhysicalAttribute;
	import pong.attr.RenderAttribute;
	import pong.sys.physics.PhysicsConfig;

	import flash.display.BitmapData;
	import flash.display.Shape;

	public class CreateBallCommand
	{
		
		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var config:PhysicsConfig;
		
		public function execute():void
		{
			var entity:Entity = system.createEntity(Names.BALL);
			
			entity.addAttribute(createPhysics());
			entity.addAttribute(createRender());
		}

		private function createPhysics():PhysicalAttribute
		{
			var toMeters:Number = config.toMeters;
			
			var def:b2BodyDef = new b2BodyDef();
			def.position.Set(700 * toMeters, 300 * toMeters);
			def.type = b2Body.b2_dynamicBody;
			def.linearVelocity = new b2Vec2(-250 * toMeters, 250 * toMeters);
			def.angularVelocity = Math.PI / 10;
			
			var fixture:b2FixtureDef = new b2FixtureDef();
			fixture.shape = new b2CircleShape(10 * toMeters);
			fixture.density = 0.0;
			fixture.restitution = 1.1;
			fixture.friction = 0;
			
			var physical:PhysicalAttribute = new PhysicalAttribute();
			physical.def = def;
			physical.fixture = fixture;
			
			return physical;
		}

		private function createRender():RenderAttribute
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x008800);
			shape.graphics.drawCircle(10, 10, 10);
			shape.graphics.endFill();
			
			var data:BitmapData = new BitmapData(20, 20, true, 0);
			data.draw(shape);
			
			var render:RenderAttribute = new RenderAttribute();
			render.offsetX = -10;
			render.offsetY = -10;
			render.data = data;
			render.rect = data.rect;
			
			return render;
		}
		
	}
}
