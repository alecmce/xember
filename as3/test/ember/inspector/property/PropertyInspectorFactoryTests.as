package ember.inspector.property
{
	import ember.inspector.property.inputs.BooleanTypeInput;
	import ember.inspector.property.inputs.IntTypeInput;
	import ember.inspector.property.inputs.NumberTypeInput;
	import ember.inspector.property.inputs.StringTypeInput;
	import ember.inspector.property.inputs.UintTypeInput;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	
	public class PropertyInspectorFactoryTests
	{
		private var factory:PropertyInspectorFactory;
		
		[Before]
		public function before():void
		{
			factory = new PropertyInspectorFactory();
		}
		
		[After]
		public function after():void
		{
			factory = null;
		}
		
		[Test]
		public function give_it_a_string_and_it_gives_back_a_StringInputType():void
		{
			var inspector:PropertyInspector = factory.getInputFor("String");
			assertThat(inspector.input, instanceOf(StringTypeInput));
		}
		
		[Test]
		public function give_it_a_boolean_and_it_gives_back_a_BooleanInputType():void
		{
			var inspector:PropertyInspector = factory.getInputFor("Boolean");
			assertThat(inspector.input, instanceOf(BooleanTypeInput));
		}
		
		[Test]
		public function give_it_an_int_and_it_gives_back_an_IntInputType():void
		{
			var inspector:PropertyInspector = factory.getInputFor("int");
			assertThat(inspector.input, instanceOf(IntTypeInput));
		}
		
		[Test]
		public function give_it_a_uint_and_it_gives_back_a_UintInputType():void
		{
			var inspector:PropertyInspector = factory.getInputFor("uint");
			assertThat(inspector.input, instanceOf(UintTypeInput));
		}
		
		[Test]
		public function give_it_a_Number_and_it_gives_back_a_NumberInputType():void
		{
			var inspector:PropertyInspector = factory.getInputFor("Number");
			assertThat(inspector.input, instanceOf(NumberTypeInput));
		}
		
	}
}
