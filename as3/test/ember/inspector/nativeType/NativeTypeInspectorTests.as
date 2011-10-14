package ember.inspector.nativeType
{
	import mocks.MockStringComponent;

	import com.bit101.components.InputText;
	import com.newloop.roboteyes.drivers.TextFieldDriver;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isTrue;

	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	public class NativeTypeInspectorTests
	{
		private static const TEST:String = "test";
		private static const ALT:String = "alt";
		private static const LABEL:String = "label";
		
		private var component:MockStringComponent;
		private var inspector:NativeTypeInspector;
		
		private var driver:TextFieldDriver;
		
		[Before]
		public function before():void
		{
			component = new MockStringComponent();
			component.label = TEST;

			var input:StringTypeInput = new StringTypeInput();
			
			inspector = new NativeTypeInspector();
			inspector.input = input;
			
			var self:DisplayObjectContainer = input.self as DisplayObjectContainer;
			var text:TextField = (self.getChildAt(0) as InputText).textField;
			
			driver = new TextFieldDriver(text);
		}
		
		[After]
		public function after():void
		{
			inspector = null;
		}
		
		[Test]
		public function can_bind_to_component():void
		{
			inspector.bind(component, LABEL);
		}
		
		[Test]
		public function binding_to_a_component_sets_inspector_value():void
		{
			inspector.bind(component, LABEL);
			assertThat(inspector.input.value, equalTo(TEST));
		}
		
		[Test]
		public function unbinding_inspector_resets_value():void
		{
			inspector.bind(component, LABEL);
			inspector.unbind();
			
			assertThat(inspector.input.value, equalTo(""));
		}
		
		[Test]
		public function clicking_on_inspector_will_focus_it():void
		{
			inspector.bind(component, LABEL);
			inspector.self.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 5, 5));
			assertThat(inspector.isFocussed, isTrue());
		}
		
		[Test]
		public function changing_bound_inspector_value_changes_component_value():void
		{
			inspector.bind(component, LABEL);
			
			inspector.self.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 5, 5));
			driver.enterText(ALT);
			driver.textField.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.ENTER));
			
			assertThat(component.label, equalTo(ALT));
		}
		
		[Test]
		public function changing_component_value_will_change_inspector_value_on_update():void
		{
			inspector.bind(component, LABEL);
			component.label = ALT;
			inspector.update();
			
			assertThat(inspector.input.value, equalTo(ALT));
		}
		
		[Test]
		public function changing_component_value_will_not_affect_inspector_while_focussed():void
		{
			inspector.bind(component, LABEL);
			
			inspector.self.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 5, 5));
			component.label = ALT;
			inspector.update();
			
			assertThat(inspector.input.value, equalTo(TEST));
		}
		
	}
}
