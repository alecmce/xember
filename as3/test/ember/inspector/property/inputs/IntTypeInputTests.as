package ember.inspector.property.inputs
{
	import asunit.asserts.fail;
	import asunit.framework.Async;
	import com.bit101.components.InputText;
	import com.newloop.roboteyes.drivers.TextFieldDriver;
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;

	public class IntTypeInputTests extends NativeTypeTestsBase
	{
		private static const TEST:int = 37;
		
		private var driver:TextFieldDriver;
		
		[Inject]
		public var async:Async;
		
		[Before]
		public function before():void
		{
			input = new IntTypeInput();
			
			var self:DisplayObjectContainer = input.self as DisplayObjectContainer;
			var text:TextField = (self.getChildAt(0) as InputText).textField;
			
			driver = new TextFieldDriver(text);
		}
		
		[After]
		public function after():void
		{
			input = null;
		}
		
		[Test]
		public function setting_input_value_when_enabled_sets_textfield():void
		{
			input.enabled = true;
			input.value = TEST;
			assertThat(driver.textIs(TEST.toString()), isTrue());
		}
		
		[Test]
		public function setting_input_value_when_disabled_has_no_effect():void
		{
			input.value = TEST;
			assertThat(driver.textIs(TEST.toString()), isFalse());
		}
		
		[Test]
		public function entering_text_does_not_trigger_changed_signal():void
		{
			input.changed.addOnce(changed_indicates_failure);
			driver.enterText(TEST.toString());
		}
		private function changed_indicates_failure(value:*):void
		{
			fail("changed signal here is inappropriate");
		}
		
		[Test]
		public function hitting_return_will_trigger_signal_with_current_value_of_textfield():void
		{
			input.enabled = true;
			input.focus = true;
			async.add(input.changed.addOnce(changed_indicates_new_value), 100);
			driver.enterText(TEST.toString());
			driver.textField.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.ENTER));
		}
		private function changed_indicates_new_value(value:*):void
		{
			assertThat(value, equalTo(TEST));
			async.cancelPending();
		}
		
		[Test]
		public function hitting_tab_will_trigger_signal_with_current_value_of_textfield():void
		{
			input.enabled = true;
			input.focus = true;
			async.add(input.changed.addOnce(changed_indicates_new_value), 100);
			driver.enterText(TEST.toString());
			driver.textField.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.TAB));
		}
		
		[Test]
		public function hitting_return_will_end_focus():void
		{
			input.enabled = true;
			input.focus = true;
			async.add(input.changed.addOnce(after_special_key_focus_is_lost), 100);
			driver.enterText(TEST.toString());
			driver.textField.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.ENTER));
		}
		private function after_special_key_focus_is_lost(value:*):void
		{
			assertThat(input.focus, isFalse());
			async.cancelPending();
		}
		
		[Test]
		public function hitting_tab_will_end_focus():void
		{
			input.enabled = true;
			input.focus = true;
			async.add(input.changed.addOnce(after_special_key_focus_is_lost), 100);
			driver.enterText(TEST.toString());
			driver.textField.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.TAB));
		}
		
	}
}
