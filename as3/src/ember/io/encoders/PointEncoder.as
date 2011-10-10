package ember.io.encoders
{
	import flash.geom.Point;

	public class PointEncoder
	{

		public function encode(point:Point):Object
		{
			return {x:point.x, y:point.y};
		}

		public function decode(obj:Object):Point
		{
			return new Point(obj.x, obj.y);
		}

	}
}
