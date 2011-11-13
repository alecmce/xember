package ember.core.ds
{
	final public class BitfieldUtil
	{
		
		public function isSubset(domain:Vector.<uint>, subset:Vector.<uint>):Boolean
		{
			var length:uint = subset.length;
			for (var i:int = 0; i < length; i++)
			{
				if ((~domain[i] & subset[i]) != 0)
					return false;
			}
			
			return true;
		}

		public function intersection(a:Vector.<uint>, b:Vector.<uint>):Vector.<uint>
		{
			var length:uint = a.length;
			if (b.length < length)
				length = b.length;

			var result:Vector.<uint> = new Vector.<uint>(length, false);
			for (var i:int = 0; i < length; i++)
				result[i] = a[i] & b[i];
			
			return result;
		}
		
		public function union(a:Vector.<uint>, b:Vector.<uint>):Vector.<uint>
		{
			var short:uint = a.length;
			var long:uint = b.length;
			if (short > long)
			{
				short ^= long;
				long ^= short;
				short ^= long;
			}
			
			var result:Vector.<uint> = new Vector.<uint>(long, false);
			for (var i:int = 0; i < short; i++)
				result[i] = a[i] | b[i];
			
			if (long == a.length)
			{
				for (i; i < long; i++)
					result[i] = a[i];
			}
			else
			{
				for (i; i < long; i++)
					result[i] = b[i];
			}
			
			return result;
		}
		
	}
}