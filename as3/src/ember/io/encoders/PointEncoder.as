package ember.io.encoders
{
	import flash.geom.Point;
	
	public class PointEncoder
	{
		
		public function encode(point:Point):Object
		{
			return {x:point.x, y:point.y};
		}
		
		public function decode(object:Object):Point
		{
			return new Point(object.x, object.y);
		}
		
	}
}
