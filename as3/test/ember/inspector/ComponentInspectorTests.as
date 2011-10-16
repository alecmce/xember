package ember.inspector
{
	import ember.io.ComponentConfig;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
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
		public function inspector_title_is_reflected():void
		{
			var component:MockAllNativeTypesComponent = new MockAllNativeTypesComponent();
			var config:ComponentConfig = new ComponentConfig("Mock", component);
			
			inspector.setComponent(component, config);
			assertThat(inspector.title, equalTo("Mock"));
		}
		
	}
}

class MockAllNativeTypesComponent
{
	
	public var a:int;
	public var b:uint;
	public var c:Number;
	public var d:String;
	public var e:Boolean;
	
}