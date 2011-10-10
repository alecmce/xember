package ember.io
{
	import mocks.MockCustomEncoder;
	import mocks.MockCustomEncoderComponent;
	import mocks.MockCustomVO;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.isTrue;
	
	public class CustomEncoderTests
	{
		private var encoder:ComponentEncoder;
		
		[Before]
		public function before():void
		{
			var factory:ComponentConfigFactory = new ComponentConfigFactory();
			encoder = new ComponentEncoder(factory);
		}
		
		[After]
		public function after():void
		{
			encoder = null;
		}
		
		// a_custom_encoder_must_ducktype_to_correct_type
		
		[Test]
		public function an_encoder_can_be_referenced_by_alias():void
		{
			encoder.addCustomEncoder(MockCustomEncoder);
		}
		
		[Test]
		public function component_encoder_will_invoke_and_use_custom_encoder_as_required():void
		{
			encoder.addCustomEncoder(MockCustomEncoder);
			
			var component:MockCustomEncoderComponent = new MockCustomEncoderComponent();
			component.normal = "hello";
			component.custom = new MockCustomVO();
			component.custom.id = 3;
			component.custom.name = "world";
			
			var vo:Object = encoder.encode(component);
			var expected:Object = {"mocks::MockCustomEncoderComponent":{normal:"hello",custom:{type:"mocks::MockCustomVO",value:"3/world"}}};
			
			assertThat(CompareVOs.objectsAreEquivalent(vo, expected), isTrue());
		}
		
	}
}