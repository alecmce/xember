package ember.core
{
	import flash.utils.Dictionary;
	
	final internal class ObjectMask
	{
		
		private var _map:Dictionary;
		private var _bit:uint;
		private var _index:uint;

		public function ObjectMask()
		{
			_map = new Dictionary();
			_bit = 0;
			_index = 0;
		}
		
		public function map(object:Object, mask:Vector.<uint> = null):Vector.<uint>
		{
			var bit:uint = _map[object] ||= ++_bit;

			--bit;
			var index:uint = bit >> 5;
			bit = bit % 32;
			
			if (mask)
				mask.length < index + 1 && (mask.length = index + 1);
			else
				mask = new Vector.<uint>(index + 1, false);
			
			mask[index] = mask[index] | (1 << bit);
			return mask;
		}

		public function unmap(object:Object, mask:Vector.<uint>):Vector.<uint>
		{
			var bit:uint = _map[object];
			if (!bit)
				return mask;
			
			--bit;
			var index:uint = bit >> 5;
			bit = bit % 32;
			
			mask[index] = mask[index] & ~(1 << bit);
			return mask;
		}

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