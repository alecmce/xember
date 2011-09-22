package pong.sys.physics
{
	import Box2D.Dynamics.b2World;
	
	public class PhysicsConfig
	{
		private var _pixelsPerMeter:Number;
		private var _toMeters:Number;
		
		private var _world:b2World;
		
		public function PhysicsConfig()
		{
			pixelsPerMeter = 30;
		}

		public function get pixelsPerMeter():Number
		{
			return _pixelsPerMeter;
		}
		
		public function set pixelsPerMeter(value:Number):void
		{
			_pixelsPerMeter = value;
			_toMeters = 1 / value;
		}
		
		public function get toPixels():Number
		{
			return _pixelsPerMeter;
		}
		
		public function get toMeters():Number
		{
			return _toMeters;
		}

		public function get world():b2World
		{
			return _world;
		}

		public function set world(world:b2World):void
		{
			_world = world;
		}
		
	}
}
