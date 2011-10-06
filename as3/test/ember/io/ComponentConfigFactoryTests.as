package ember.io
{
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertSame;

	import mocks.MockRenderComponent;
	
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
			var a:ComponentConfig = configFactory.get(new MockRenderComponent());
			
			assertNotNull(a);
		}
		
		[Test]
		public function does_not_duplicate_configs_for_components_of_same_type():void
		{
			var a:ComponentConfig = configFactory.get(new MockRenderComponent());
			var b:ComponentConfig = configFactory.get(new MockRenderComponent());
			
			assertSame(a, b);
		}
		
		
	}
}
