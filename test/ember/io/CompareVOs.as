package ember.io
{
	public class CompareVOs
	{
		
		public static function objectsAreEquivalent(a:Object, b:Object):Boolean
		{
			var value:Boolean = false;
			if (!a || !b)
				return false;
			
			for (var key:String in a)
			{
				value = true;
				if (a[key] != b[key] && !objectsAreEquivalent(a[key], b[key]))
					return false;
			}
			
			return value;
		}
		
	}
}
