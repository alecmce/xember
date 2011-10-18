package ember.inspector
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.sameInstance;

	
	public class ComponentInspectorTests
	{
		private var inspector:ComponentInspector;
		
		[Before]
		public function before():void
		{
			inspector = new ComponentInspector();
		}
		
		[After]
		public function after():void
		{
			inspector = null;
		}
		
		[Test]
		public function can_set_title():void
		{
			inspector.title = "Test";
			assertThat(inspector.title, equalTo("Test"));
		}
		
		[Test]
		public function can_get_properties_by_label():void
		{
			var mock:MockInspector = new MockInspector();
			inspector.addProperty("label", mock);
			
			assertThat(inspector.getProperty("label"), sameInstance(mock));
		}
		
		[Test]
		public function calling_update_calls_update_of_all_property_inspectors():void
		{
			var mock:MockInspector = new MockInspector();
			inspector.addProperty("label", mock);
			inspector.update();
			
			assertThat(mock.wasUpdated, isTrue());
		}
		
	}
}

import ember.inspector.PropertyInspector;

import flash.display.DisplayObject;
import flash.display.Sprite;

class MockInspector implements PropertyInspector
{
	private var _self:Sprite;
	
	public var wasUpdated:Boolean;

	public function MockInspector()
	{
		_self = new Sprite();
	}
	
	public function get self():DisplayObject
	{
		return _self;
	}

	public function bind(component:Object, property:String):void
	{
		// do nothing
	}

	public function unbind():void
	{
		// do nothing
	}

	public function update():void
	{
		wasUpdated = true;
	}
	
}