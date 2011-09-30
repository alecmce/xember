package ember.io
{
	public class CompareVOs
	{
		
		public static function objectsAreEquivalent(a:Object, b:Object):Boolean
		{
			if (a == null || b == null)
				return false;
			
			if (isValue(a) && isValue(b))
				return a == b;
			
			for (var key:String in a)
			{
				if (a[key] != b[key] && !objectsAreEquivalent(a[key], b[key]))
					return false;
			}
			
			return true;
		}
		
		private static function isValue(object:Object):Boolean
		{
			return object is String || object is Number || object is Boolean;
		}
		
	}
}
