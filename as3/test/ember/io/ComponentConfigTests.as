package ember.io
{
	import mocks.MockComponent;
	import mocks.MockEncodeAllComponent;
	import mocks.MockMetadataComponent;
	import mocks.MockTypesComponent;

	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.object.sameInstance;

	import flash.geom.Point;

	public class ComponentConfigTests
	{
		
		[Test]
		public function config_generates_list_of_properties():void
		{
			var config:ComponentConfig = new ComponentConfig("Mock", new MockComponent());
			assertThat(config.properties, hasItem("n"));
		}
		
		[Test]
		public function can_reference_base_types_via_config():void
		{
			var config:ComponentConfig = new ComponentConfig("Mock", new MockTypesComponent());
			assertThat(config.getType("arr"), sameInstance(Array));
		}
		
		[Test]
		public function can_reference_packaged_types_via_config():void
		{
			var config:ComponentConfig = new ComponentConfig("Mock", new MockTypesComponent());
			assertThat(config.getType("point"), sameInstance(Point));
		}
		
		[Test]
		public function config_ignores_properties_without_Ember_metadata():void
		{
			var config:ComponentConfig = new ComponentConfig("Mock", new MockMetadataComponent());
			assertThat(config.properties, array("a"));
		}
		
		[Test]
		public function marking_a_class_with_encode_all_overrides_metadata():void
		{
			var config:ComponentConfig = new ComponentConfig("Mock", new MockEncodeAllComponent());
			assertThat(config.properties, hasItems("a", "str"));
		}
		
	}
}
