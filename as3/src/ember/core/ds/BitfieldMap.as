package ember.core.ds
{
	import flash.utils.Dictionary;
	
	final public class BitfieldMap
	{
		
		private var _map:Dictionary;
		private var _bit:uint;
		private var _index:uint;

		public function BitfieldMap()
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
		
	}
}