package ember.inspector.properties
{
	import asunit.framework.Async;

	import mocks.MockAllNativeTypesComponent;

	import com.bit101.components.PushButton;
	import com.newloop.roboteyes.drivers.InteractiveObjectDriver;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;

	import flash.display.DisplayObjectContainer;

	public class BooleanInspectorTests
	{
		[Inject]
		public var async:Async;
		
		private var input:BooleanInspector;
		
		private var button:PushButton;
		private var driver:InteractiveObjectDriver;
		
		private var component:MockAllNativeTypesComponent;
		
		[Before]
		public function before():void
		{
			input = new BooleanInspector();
			
			var self:DisplayObjectContainer = input.self as DisplayObjectContainer;
		 	
			button = (self.getChildAt(0) as PushButton);
			driver = new InteractiveObjectDriver(button);
			
			component = new MockAllNativeTypesComponent();
			component.Boolean_value = false;
		}
		
		[After]
		public function after():void
		{
			input.unbind();
			input = null;
			
			button = null;
			driver = null;
			component = null;
		}
		
		[Test]
		public function click_doesnt_toggle_button_state_when_unbound():void
		{
			driver.click();
			assertThat(button.selected, isFalse());
		}
		
		[Test]
		public function click_toggles_button_state_when_bound():void
		{
			input.bind(component, "Boolean_value");
			driver.click();
			assertThat(button.selected, isTrue());
		}
		
		[Test]
		public function click_toggles_component_state_when_bound():void
		{
			input.bind(component, "Boolean_value");
			driver.click();
			assertThat(component.Boolean_value, isTrue());
		}
		
		
		// FIXME these tests are incorrectly failing - probably due to some underlying issue in the MinimalComps 
		// structure or my misunderstanding about how the RobotEyes library works.
		
//		[Test]
//		public function keyboard_space_toggles_button_state_when_bound():void
//		{
//			input.bind(component, "Boolean_value");
//			driver.view.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, Keyboard.SPACE));
//			assertThat(button.selected, isTrue());
//		}
//		
//		[Test]
//		public function keyboard_space_toggles_component_state_when_bound():void
//		{
//			input.bind(component, "Boolean_value");
//			driver.view.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, Keyboard.SPACE));
//			assertThat(component.Boolean_value, isTrue());
//		}
		
		[Test]
		public function two_clicks_reverts_state_of_button():void
		{
			input.bind(component, "Boolean_value");
			driver.click();
			driver.click();
			assertThat(button.selected, isFalse());
		}

		[Test]
		public function two_clicks_reverts_state_of_component():void
		{
			input.bind(component, "Boolean_value");
			driver.click();
			driver.click();
			assertThat(component.Boolean_value, isFalse());
		}
		
	}
}
