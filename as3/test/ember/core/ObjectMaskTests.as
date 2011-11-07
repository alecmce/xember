package ember.core
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	
	public class ObjectMaskTests
	{
		private var _map:ObjectMask;
		
		[Before]
		public function before():void
		{
			_map = new ObjectMask();
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
		
		[Test]
		public function isSubset_is_true_when_all_bits_in_second_mask_are_in_first():void
		{
			var domain:Vector.<uint> = Vector.<uint>([13]);				// 1101
			var subset:Vector.<uint> = Vector.<uint>([9]);  			// 1001
			
			assertThat(_map.isSubset(domain, subset), isTrue());
		}
		
		[Test]
		public function isSubset_is_not_affected_by_extra_indices_in_domain():void
		{
			var domain:Vector.<uint> = Vector.<uint>([13,1]);			// 1101, 1
			var subset:Vector.<uint> = Vector.<uint>([9]);  			// 1001, 0
			
			assertThat(_map.isSubset(domain, subset), isTrue());
		}
		
		[Test]
		public function isSubset_is_false_when_a_bit_in_second_mask_is_not_in_first():void
		{
			var domain:Vector.<uint> = Vector.<uint>([13]);				// 1101
			var subset:Vector.<uint> = Vector.<uint>([10]);  			// 1010
		
			assertThat(_map.isSubset(domain, subset), isFalse());
		}
		
		[Test]
		public function isSubset_fails_if_bit_in_second_mask_is_not_in_first_in_any_index():void
		{
			var domain:Vector.<uint> = Vector.<uint>([1, 13]);			// 1, 1101
			var subset:Vector.<uint> = Vector.<uint>([1, 10]);  		// 1, 1010
		
			assertThat(_map.isSubset(domain, subset), isFalse());
		}
		
		[Test]
		public function isSubset_is_affected_by_extra_indices_in_subset():void
		{
			var domain:Vector.<uint> = Vector.<uint>([13]);				// 1101
			var subset:Vector.<uint> = Vector.<uint>([10, 1]);  		// 1010, 1
		
			assertThat(_map.isSubset(domain, subset), isFalse());
		}
		
		[Test]
		public function can_get_intersection_of_sets():void
		{
			var a:Vector.<uint> = Vector.<uint>([3]);
			var b:Vector.<uint> = Vector.<uint>([5]);
			
			assertThat(_map.intersection(a, b), matchesVector(1));
		}
		
		[Test]
		public function can_get_intersection_of_sets_with_multiple_values():void
		{
			var a:Vector.<uint> = Vector.<uint>([5, 3]);				// 101, 011
			var b:Vector.<uint> = Vector.<uint>([3, 2]);				// 011, 010
			
			assertThat(_map.intersection(a, b), matchesVector(1, 2));	// 001, 010
		}
		
		[Test]
		public function can_get_intersection_of_sets_where_first_set_is_longer():void
		{
			var a:Vector.<uint> = Vector.<uint>([3, 1]);				// 001, 011
			var b:Vector.<uint> = Vector.<uint>([6]);					// 110, 000
			
			assertThat(_map.intersection(a, b), matchesVector(2));		// 000, 010
		}
		
		[Test]
		public function can_get_intersection_of_sets_where_second_set_is_longer():void
		{
			var a:Vector.<uint> = Vector.<uint>([3]);					// 000, 011
			var b:Vector.<uint> = Vector.<uint>([6, 1]);				// 110, 001
			
			assertThat(_map.intersection(a, b), matchesVector(2));		// 000, 010
		}
		
		[Test]
		public function can_get_union_of_sets():void
		{
			var a:Vector.<uint> = Vector.<uint>([3]);					// 011
			var b:Vector.<uint> = Vector.<uint>([5]);					// 101
			
			assertThat(_map.union(a, b), matchesVector(7));				// 111
		}
		
		[Test]
		public function can_get_union_of_state_where_first_set_is_longer():void
		{
			var a:Vector.<uint> = Vector.<uint>([5, 4]);				// 101, 100
			var b:Vector.<uint> = Vector.<uint>([1]);					// 001, 000
			
			assertThat(_map.union(a, b), matchesVector(5, 4));			// 101, 100
		}
		
		[Test]
		public function can_get_union_of_state_where_second_set_is_longer():void
		{
			var a:Vector.<uint> = Vector.<uint>([2]);					// 010, 000
			var b:Vector.<uint> = Vector.<uint>([5, 1]);				// 101, 001
			
			assertThat(_map.union(a, b), matchesVector(7, 1));			// 111, 001
		}
		
	}
}