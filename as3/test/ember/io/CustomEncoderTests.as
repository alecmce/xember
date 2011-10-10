package ember.io
{
	import mocks.MockCustomEncoder;
	import mocks.MockCustomVO;

	import org.hamcrest.assertThat;
	
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
			var component:MockComponent = new MockComponent();
			component.normal = "hello";
			component.custom = new MockCustomVO();
			component.custom.id = 3;
			component.custom.name = "world";
			
			var vo:Object = encoder.encode(component);
			assertThat(CompareVOs.objectsAreEquivalent(vo, {normal:"hello",label:"3/world"}));
		}
		
	}
}

import mocks.MockCustomVO;

[Ember(encodeAll)]
class MockComponent
{
	
	public var normal:String;
	
	[Ember(encoder="mocks::MockCustomEncoder")]
	public var custom:MockCustomVO;
	
}
