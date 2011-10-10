package ember.io
{
	import mocks.MockAltCustomEncoder;
	import mocks.MockCustomEncoder;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	
	public class CustomEncodersTests
	{
		private var encoders:CustomEncoders;
		
		[Before]
		public function before():void
		{
			encoders = new CustomEncoders();
		}
		
		[After]
		public function after():void
		{
			encoders = null;
		}
		
		[Test]
		public function you_can_add_a_custom_encoder():void
		{
			assertThat(encoders.addEncoder(MockCustomEncoder), isTrue());
		}
		
		[Test]
		public function you_can_remove_a_custom_encoder():void
		{
			encoders.addEncoder(MockCustomEncoder);
			assertThat(encoders.removeEncoder(MockCustomEncoder), isTrue());
		}
		
		[Test]
		public function you_cannot_remove_a_custom_encoder_you_havent_added():void
		{
			assertThat(encoders.removeEncoder(MockCustomEncoder), isFalse());
		}
		
		[Test]
		public function an_encoder_instance_can_be_referenced_by_the_type_it_encodes_once_added():void
		{
			encoders.addEncoder(MockCustomEncoder);
			assertThat(encoders.getEncoderForType("mocks::MockCustomVO"), isA(MockCustomEncoder));
		}
		
		[Test]
		public function an_invalid_encoder_ducktype_will_throw_a_warning():void
		{
			assertThat(add_non_custom_encoder, throws(Error));
		}
		private function add_non_custom_encoder():void
		{
			encoders.addEncoder(Object);
		}
		
		[Test]
		public function two_custom_encoders_cannot_encode_the_same_type():void
		{
			encoders.addEncoder(MockCustomEncoder);
			assertThat(add_second_encoder, throws(Error));
		}
		private function add_second_encoder():void
		{
			encoders.addEncoder(MockAltCustomEncoder);
		}
		
	}
}
