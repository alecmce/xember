package ember.io
{
	import mocks.MockComponent;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.sameInstance;
	
	public class ComponentConfigFactoryTests
	{
		private var configFactory:ComponentConfigFactory;
		
		[Before]
		public function before():void
		{
			configFactory = new ComponentConfigFactory();
		}
		
		[After]
		public function after():void
		{
			configFactory = null;
		}
		
		[Test]
		public function can_generate_config_for_component():void
		{
			assertThat(configFactory.get(new MockComponent()), notNullValue());
		}
		
		[Test]
		public function does_not_duplicate_configs_for_components_of_same_type():void
		{
			var first:ComponentConfig = configFactory.get(new MockComponent());
			assertThat(configFactory.get(new MockComponent()), sameInstance(first));
		}
		
	}
}
