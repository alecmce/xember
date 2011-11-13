package ember.core.ds
{
	import ember.core.matchesVector;

	import org.hamcrest.assertThat;
	
	public class BitfieldMapTests
	{
		private var _map:BitfieldMap;
		
		[Before]
		public function before():void
		{
			_map = new BitfieldMap();
		}
		
		[After]
		public function after():void
		{
			_map = null;
		}
		
		[Test]
		public function first_mapped_class_gives_back_1():void
		{
			assertThat(_map.map({}), matchesVector(1));
		}
		
		[Test]
		public function retrieving_mapped_class_gives_same_value_as_mapping():void
		{
			var obj:Object = {};
			_map.map(obj);
			assertThat(_map.map(obj), matchesVector(1));
		}
		
		[Test]
		public function third_mapping_gives_back_4():void
		{
			_map.map({});	
			_map.map({});	
			assertThat(_map.map({}), matchesVector(4));
		}
		
		[Test]
		public function return_value_is_disjoint_mask_if_original_mask_passed_in():void
		{
			var mask:Vector.<uint> = Vector.<uint>([2,4]);
			
			assertThat(_map.map({}, mask), matchesVector(3,4));
		}
		
		[Test]
		public function thirty_third_mapping_gives_back_1_in_2nd_index():void
		{
			var i:int = 32;
			while (i--)
				_map.map({});
			
			assertThat(_map.map({}), matchesVector(0, 1));
		}
		
		[Test]
		public function can_unmap_value_from_a_mask():void
		{
			var mask:Vector.<uint> = Vector.<uint>([7]);
			var unmap:Object = {};
			
			_map.map({});
			_map.map(unmap);
			_map.map({});
			
			assertThat(_map.unmap(unmap, mask), matchesVector(5));
		}
		
	}
}