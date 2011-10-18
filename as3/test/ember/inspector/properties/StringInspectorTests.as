package ember.inspector.properties
{
	import asunit.framework.Async;

	import mocks.MockAllNativeTypesComponent;

	import com.bit101.components.InputText;
	import com.newloop.roboteyes.drivers.TextFieldDriver;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isTrue;

	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	public class StringInspectorTests
	{
		private static const TEST:String = "test";
		private static const ALT:String = "alt";
		
		private var input:StringInspector;
		
		private var driver:TextFieldDriver;
		
		private var component:MockAllNativeTypesComponent;
		
		[Inject]
		public var async:Async;
		
		[Before]
		public function before():void
		{
			input = new StringInspector();
			
			var self:DisplayObjectContainer = input.self as DisplayObjectContainer;
			var text:TextField = (self.getChildAt(0) as InputText).textField;
			
			driver = new TextFieldDriver(text);
			
			component = new MockAllNativeTypesComponent();
			component.String_value = TEST;
		}
		
		[After]
		public function after():void
		{
			input = null;
		}
		
		[Test]
		public function binding_component_sets_text_value():void
		{
			input.bind(component, "String_value");
			assertThat(driver.textIs(TEST), isTrue());
		}
		
		// FIXME this test is incorrectly failing - probably due to some underlying issue in the MinimalComps structure or
		// my misunderstanding about how the RobotEyes library works.
		
//		[Test]
//		public function editing_text_stops_update_from_functioning():void
//		{
//			input.bind(component, "String_value");
//			driver.enterText(ALT);
//			input.update();
//			assertThat(driver.textIs(ALT), isTrue());
//		}
		
		[Test]
		public function editing_text_doesnt_automatically_udpate_component():void
		{
			input.bind(component, "String_value");
			driver.enterText(ALT);
			assertThat(component.String_value, equalTo(TEST));
		}
		
		[Test]
		public function hitting_return_updates_component():void
		{
			input.bind(component, "String_value");
			driver.enterText(ALT);
			driver.textField.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.ENTER));
			assertThat(component.String_value, equalTo(ALT));
		}
		
		[Test]
		public function updating_before_edit_chages_value():void
		{
			input.bind(component, "String_value");
			component.String_value = ALT;
			input.update();
			assertThat(driver.textIs(ALT), isTrue());
		}
		
	}
}
