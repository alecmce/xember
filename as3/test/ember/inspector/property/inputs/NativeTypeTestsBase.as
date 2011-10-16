package ember.inspector.property.inputs
{
	import ember.inspector.property.PropertyInput;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	
	public class NativeTypeTestsBase
	{
		
		public var input:PropertyInput;
		
		[Test]
		public function by_default_focus_is_false():void
		{
			assertThat(input.focus, isFalse());
		}
		
		[Test]
		public function by_default_enabled_is_false():void
		{
			assertThat(input.enabled, isFalse());
		}
		
		[Test]
		public function cannot_focus_if_disabled():void
		{
			input.focus = true;
			assertThat(input.focus, isFalse());
		}
		
		[Test]
		public function can_enable():void
		{
			input.enabled = true;
			assertThat(input.enabled, isTrue());
		}
		
		[Test]
		public function can_disable():void
		{
			input.enabled = true;
			input.enabled = false;
			assertThat(input.enabled, isFalse());
		}
		
		[Test]
		public function can_focus_if_enabled():void
		{
			input.enabled = true;
			input.focus = true;
			assertThat(input.focus, isTrue());
		}
		
		[Test]
		public function when_disabled_focus_is_falsed():void
		{
			input.enabled = true;
			input.focus = true;
			input.enabled = false;
			assertThat(input.focus, isFalse());
		}
		
	}
}
