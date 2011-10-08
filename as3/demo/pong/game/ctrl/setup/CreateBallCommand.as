package pong.game.ctrl.setup
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import ember.core.Entity;
	import ember.core.Ember;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import pong.game.Names;
	import pong.game.attr.PhysicalComponent;
	import pong.game.attr.RenderComponent;
	import pong.game.sys.physics.PhysicsConfig;




	public class CreateBallCommand
	{
		
		[Inject]
		public var system:Ember;
		
		[Inject]
		public var config:PhysicsConfig;
		
		public function execute():void
		{
			var entity:Entity = system.createEntity(Names.BALL);
			
			entity.addComponent(createPhysics());
			entity.addComponent(createRender());
		}

		private function createPhysics():PhysicalComponent
		{
			var toMeters:Number = config.toMeters;
			
			var x:Number = 200 + Math.random() * 400;
			var y:Number = 200 + Math.random() * 200;
			var a:Number = Math.random() * Math.PI * 0.5 - 0.25;
			var ax:Number = 800 * Math.cos(a);
			var ay:Number = 800 * Math.sin(a);
			var b:Number = Math.random() * Math.PI - Math.PI;
			
			var def:b2BodyDef = new b2BodyDef();
			def.position.Set(x * toMeters, y * toMeters);
			def.type = b2Body.b2_dynamicBody;
			def.linearVelocity = new b2Vec2(ax * toMeters, ay * toMeters);
			def.angularVelocity = b;
			
			var fixture:b2FixtureDef = new b2FixtureDef();
			fixture.shape = new b2CircleShape(10 * toMeters);
			fixture.density = 0.0;
			fixture.restitution = 1.03;
			fixture.friction = 0.4;
			
			var physical:PhysicalComponent = new PhysicalComponent();
			physical.def = def;
			physical.fixture = fixture;
			
			return physical;
		}

		private function createRender():RenderComponent
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFFEE00);
			shape.graphics.drawCircle(10, 10, 10);
			shape.graphics.endFill();
			
			var data:BitmapData = new BitmapData(20, 20, true, 0);
			data.draw(shape);
			
			var render:RenderComponent = new RenderComponent();
			render.offsetX = -10;
			render.offsetY = -10;
			render.data = data;
			render.rect = data.rect;
			
			return render;
		}
		
	}
}
