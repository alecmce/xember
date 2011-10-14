package ember.inspector.nativeType
{
	import mocks.MockStringComponent;

	import com.newloop.roboteyes.drivers.TextFieldDriver;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.sameInstance;

	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	public class NativeTypeInspectorTests
	{
		private static const TEST:String = "test";
		private static const ALT:String = "alt";
		private static const LABEL:String = "label";
		
		private var component:MockStringComponent;
		private var inspector:NativeTypeInspector;
		
		[Inject]
		public var container:Sprite;
		
		[Before]
		public function before():void
		{
			component = new MockStringComponent();
			component.label = TEST;
			
			inspector = new NativeTypeInspector();
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
			assertThat(inspector.value, equalTo(TEST));
		}
		
		[Test]
		public function can_unbind_bound_inspector():void
		{
			inspector.bind(component, LABEL);
			inspector.unbind();
			
			assertThat(inspector.value, equalTo(""));
		}
		
		[Test]
		public function changing_bound_inspector_value_changes_component_value():void
		{
			inspector.bind(component, LABEL);
			inspector.value = ALT;
			
			assertThat(component.label, equalTo(ALT));
		}
		
		[Test]
		public function can_add_inspector_to_stage():void
		{
			container.addChild(inspector);
			assertThat(inspector.parent, sameInstance(container));
		}
		
		[Test]
		public function changing_component_value_will_change_inspector_value_on_update():void
		{
			inspector.bind(component, LABEL);
			component.label = ALT;
			update.dispatch();
			
			assertThat(inspector.value, equalTo(ALT));
		}
		
		[Test]
		public function clicking_on_inspector_will_focus_it():void
		{
			inspector.bind(component, LABEL);
			inspector.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 5, 5));
			assertThat(inspector.isFocussed, isTrue());
		}
		
		[Test]
		public function changing_component_value_will_not_affect_inspector_while_focussed():void
		{
			inspector.bind(component, LABEL);
			container.addChild(inspector);
			
			inspector.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 5, 5));
			component.label = ALT;
			update.dispatch();
			
			assertThat(inspector.value, equalTo(TEST));
		}
		
		[Test]
		public function hitting_return_will_push_inspector_value_to_component():void
		{
			inspector.bind(component, LABEL);
			container.addChild(inspector);
			
			inspector.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 5, 5));
			new TextFieldDriver(inspector.input.textField).enterText(ALT);
			inspector.input.textField.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.ENTER));
			
			assertThat(component.label, equalTo(ALT));
		}
		
		[Test]
		public function hitting_alt_will_push_inspector_value_to_component():void
		{
			inspector.bind(component, LABEL);
			container.addChild(inspector);
			
			inspector.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 5, 5));
			new TextFieldDriver(inspector.input.textField).enterText(ALT);
			inspector.input.textField.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, Keyboard.TAB));
			
			assertThat(component.label, equalTo(ALT));
		}
		
	}
}
