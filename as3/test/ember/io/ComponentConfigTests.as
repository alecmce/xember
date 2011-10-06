package ember.io
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertEqualsArraysIgnoringOrder;

	import mocks.MetadataComponent;
	import mocks.MockMixedTypeComponent;
	import mocks.MockSpatialComponent;
	
	public class ComponentConfigTests
	{
		
		[Test]
		public function config_generates_list_of_properties():void
		{
			var config:ComponentConfig = new ComponentConfig("Mock", new MockSpatialComponent());
			var properties:Array = convertToArray(config.properties);
			
			assertEqualsArraysIgnoringOrder(["x","y"], properties);
		}
		
		[Test]
		public function can_reference_type_through_config():void
		{
			var config:ComponentConfig = new ComponentConfig("Mock", new MockMixedTypeComponent());
			
			assertEquals("int", config.getType("n"));
			assertEquals("Array", config.getType("arr"));
			assertEquals("flash.geom.Point", config.getType("point"));
		}
		
		[Test]
		public function config_ignores_properties_without_Ember_metadata():void
		{
			var config:ComponentConfig = new ComponentConfig("Mock", new MetadataComponent());
			var properties:Array = convertToArray(config.properties);
			
			assertEqualsArraysIgnoringOrder(["a"], properties);
		}
		
		private function convertToArray(properties:Vector.<String>):Array
		{
			var i:uint = properties.length;
			var array:Array = [];
			while (i--)
				array[i] = properties[i];
			
			return array;
		}
		
	}
}
