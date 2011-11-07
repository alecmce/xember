package ember.core
{
	import mocks.extending.MockBase;
	import mocks.extending.MockExtendsA;
	import mocks.extending.MockExtendsB;
	import mocks.extending.MockExtendsTwice;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.sameInstance;
	
	public class ComponentMaskFactoryTests
	{
		private var mask:ObjectMask;
		private var factory:ComponentMaskFactory;
		
		[Before]
		public function before():void
		{
			mask = new ObjectMask();
			factory = new ComponentMaskFactory(mask);
		}
		
		[After]
		public function after():void
		{
			factory = null;
		}
		
		[Test]
		public function getMask_returns_a_bitfield_mask():void
		{
			var mask:Vector.<uint> = factory.getMask(MockBase);
			assertThat(mask, matchesVector(1));
		}
		
		[Test]
		public function bitfield_masks_are_cached():void
		{
			var a:Vector.<uint> = factory.getMask(MockBase);
			var b:Vector.<uint> = factory.getMask(MockBase);
			
			assertThat(a, sameInstance(b));
		}
		
		[Test]
		public function a_component_with_a_subtype_contains_a_two_bit_mask():void
		{
			var mask:Vector.<uint> = factory.getMask(MockExtendsA);
			assertThat(mask, matchesVector(3));
		}
		
		[Test]
		public function a_component_with_a_two_subtypes_contains_a_three_bit_mask():void
		{
			var mask:Vector.<uint> = factory.getMask(MockExtendsTwice);
			assertThat(mask, matchesVector(7));
		}
		
		[Test]
		public function two_components_with_same_base_class_share_a_bit():void
		{
			var a:Vector.<uint> = factory.getMask(MockExtendsA);
			var b:Vector.<uint> = factory.getMask(MockExtendsB);
			
			var result:Vector.<uint> = mask.intersection(a, b);
			var isValue:Boolean = false;
			for (var i:int = 0; i < result.length; i++)
				isValue ||= result[i] != 0;
			
			assertThat(isValue, isTrue());
		}
		
	}
	
}