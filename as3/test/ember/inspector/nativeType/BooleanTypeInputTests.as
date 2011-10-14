package ember.inspector.nativeType
{
	import asunit.framework.Async;

	import com.bit101.components.PushButton;
	import com.newloop.roboteyes.drivers.InteractiveObjectDriver;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;

	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class BooleanTypeInputTests extends NativeTypeTestsBase
	{
		
		[Inject]
		public var async:Async;
		
		private var driver:InteractiveObjectDriver;
		
		[Before]
		public function before():void
		{
			input = new BooleanTypeInput();
			
			var self:DisplayObjectContainer = input.self as DisplayObjectContainer;
			var button:PushButton = (self.getChildAt(0) as PushButton);
			
			driver = new InteractiveObjectDriver(button);
		}
		
		[After]
		public function after():void
		{
			input = null;
		}
		
		[Test]
		public function toggling_value_when_disabled_has_no_effect():void
		{
			input.value = true;
			assertThat(input.value, isFalse());
		}
		
		[Test]
		public function toggling_value_when_enabled_has_effect():void
		{
			input.enabled = true;
			input.value = true;
			assertThat(input.value, isTrue());
		}
		
		[Test]
		public function hitting_space_toggles_value():void
		{
			input.enabled = true;
			input.focus = true;
			driver.view.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.SPACE));
			assertThat(input.value, isTrue());
		}
		
		[Test]
		public function hitting_space_keeps_focus():void
		{
			input.enabled = true;
			input.focus = true;
			driver.view.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.SPACE));
			assertThat(input.value, isTrue());
		}
		
		[Test]
		public function hitting_return_keeps_value():void
		{
			input.enabled = true;
			input.focus = true;
			input.value = true;
			driver.view.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.ENTER));
			assertThat(input.value, isTrue());
		}
		
		[Test]
		public function hitting_return_loses_focus():void
		{
			input.enabled = true;
			input.focus = true;
			driver.view.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.ENTER));
			assertThat(input.focus, isFalse());
		}
		
	}
}
