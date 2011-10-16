package ember.inspector
{
	import ember.inspector.property.PropertyInspector;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
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
			var property:PropertyInspector = new PropertyInspector();
			inspector.addProperty("label", property);
			
			assertThat(inspector.getProperty("label"), sameInstance(property));
		}
		
	}
}