package ember.inspector
{
	import ember.inspector.properties.StringInspector;

	import mocks.MockStringComponent;

	import com.bit101.components.InputText;
	import com.newloop.roboteyes.drivers.TextFieldDriver;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	public class PropertyInspectorTests
	{
		private static const TEST:String = "test";
		
		private var component:MockStringComponent;
		private var wrapper:PropertyWrapper;
		
		private var driver:TextFieldDriver;
		
		[Before]
		public function before():void
		{
			component = new MockStringComponent();
			component.label = TEST;

			var inspector:StringInspector = new StringInspector();
			
			wrapper = new PropertyWrapper();
			wrapper.inspector = inspector;
			
			var self:DisplayObjectContainer = inspector.self as DisplayObjectContainer;
			var text:TextField = (self.getChildAt(0) as InputText).textField;
			
			driver = new TextFieldDriver(text);
		}
		
		[After]
		public function after():void
		{
			wrapper = null;
		}
		
		[Test]
		public function can_define_label_for_wrapper():void
		{
			wrapper.label = TEST;
			assertThat(wrapper.label, equalTo(TEST));
		}
		
	}
}
