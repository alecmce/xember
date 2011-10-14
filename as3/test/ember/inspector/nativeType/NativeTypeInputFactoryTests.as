package ember.inspector.nativeType
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	
	public class NativeTypeInputFactoryTests
	{
		private var factory:NativeTypeInputFactory;
		
		[Before]
		public function before():void
		{
			factory = new NativeTypeInputFactory();
		}
		
		[After]
		public function after():void
		{
			factory = null;
		}
		
		[Test]
		public function give_it_a_string_and_it_gives_back_a_StringInputType():void
		{
			var value:String = "value";
			var input:NativeTypeInput = factory.getInputFor(value);
			assertThat(input, instanceOf(StringTypeInput));
		}
		
		[Test]
		public function give_it_a_boolean_and_it_gives_back_a_BooleanInputType():void
		{
			var flag:Boolean = false;
			var input:NativeTypeInput = factory.getInputFor(flag);
			assertThat(input, instanceOf(BooleanTypeInput));
		}
		
		[Test]
		public function give_it_an_int_and_it_gives_back_an_IntInputType():void
		{
			var value:int = 3;
			var input:NativeTypeInput = factory.getInputFor(value);
			assertThat(input, instanceOf(IntTypeInput));
		}
		
	}
}
