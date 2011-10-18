package ember.inspector
{
	import ember.inspector.properties.BooleanInspector;
	import ember.inspector.properties.IntInspector;
	import ember.inspector.properties.NumberInspector;
	import ember.inspector.properties.StringInspector;
	import ember.inspector.properties.UintInspector;

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
		public function give_it_a_string_and_it_gives_back_a_StringInspector():void
		{
			var inspector:PropertyInspector = factory.getInspector(String);
			assertThat(inspector, instanceOf(StringInspector));
		}
		
		[Test]
		public function give_it_a_boolean_and_it_gives_back_a_BooleanInspector():void
		{
			var inspector:PropertyInspector = factory.getInspector(Boolean);
			assertThat(inspector, instanceOf(BooleanInspector));
		}
		
		[Test]
		public function give_it_an_int_and_it_gives_back_an_IntInspector():void
		{
			var inspector:PropertyInspector = factory.getInspector(int);
			assertThat(inspector, instanceOf(IntInspector));
		}
		
		[Test]
		public function give_it_a_uint_and_it_gives_back_a_UintInspector():void
		{
			var inspector:PropertyInspector = factory.getInspector(uint);
			assertThat(inspector, instanceOf(UintInspector));
		}
		
		[Test]
		public function give_it_a_Number_and_it_gives_back_a_NumberInspector():void
		{
			var inspector:PropertyInspector = factory.getInspector(Number);
			assertThat(inspector, instanceOf(NumberInspector));
		}
		
	}
}
