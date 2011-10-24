package inspector.prefab
{
	import ember.core.Ember;
	import ember.core.Entity;

	import inspector.components.Movement;
	import inspector.components.RenderComponent;
	import inspector.components.SpatialComponent;
	import inspector.components.World;
	import inspector.util.Random;
	import inspector.util.RandomColors;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	public class BallFactory
	{
		private var _world:World;

		private var _ember:Ember;
		private var _random:Random;
		private var _colors:RandomColors;

		public function BallFactory(ember:Ember, random:Random, colors:RandomColors)
		{
			_world = generateWorld();

			_ember = ember;
			_random = random;
			_colors = colors;
		}

		public function create():Entity
		{
			var radius:uint = _random.nextInt(20) + 10;
			var x:uint = _random.nextInt(560) + 40;
			var y:uint = _random.nextInt(400) + 40;
			var color:uint = _colors.nextColor();

			var entity:Entity = _ember.createEntity();
			entity.addComponent(_world);
			entity.addComponent(generateSpatialComponent(x, y, radius));
			entity.addComponent(generateRenderComponent(radius, color));
			entity.addComponent(generatePhysicsComponent());
			return entity;
		}

		private function generateWorld():World
		{
			var world:World = new World();
			
			world.gx = 0;
			world.gy = 0.4;
			world.size = new Rectangle(20, 20, 600, 440);
			world.restitution = 1;

			return world;
		}

		private function generateSpatialComponent(x:int, y:int, radius:uint):Object
		{
			var component:SpatialComponent = new SpatialComponent();
			
			component.x = x;
			component.y = y;
			component.radius = radius;

			return component;
		}

		private function generateRenderComponent(radius:uint, color:uint):Object
		{
			var size:int = radius << 1;

			var shape:Shape = new Shape();
			shape.graphics.beginFill(color);
			shape.graphics.drawCircle(radius, radius, radius);
			shape.graphics.endFill();

			var component:RenderComponent = new RenderComponent();
			component.data = new BitmapData(size, size, true, 0);
			component.data.draw(shape);

			return component;
		}

		private function generatePhysicsComponent():Object
		{
			var component:Movement = new Movement();

			component.dx = _random.nextDouble(10) - 5;
			component.dy = _random.nextDouble(10) - 5;

			return component;
		}

	}
}
