package ember.io.encoders
{
	import flash.geom.Rectangle;

	public class RectangleEncoder
	{

		public function encode(rect:Rectangle):Object
		{
			return {x:rect.x, y:rect.y, w:rect.width, h:rect.height};
		}

		public function decode(obj:Object):Rectangle
		{
			return new Rectangle(obj.x, obj.y, obj.w, obj.h);
		}

	}
}
