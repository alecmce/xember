package ember
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;

	import ember.mocks.RenderAttribute;
	import ember.mocks.RenderNode;
	import ember.mocks.SpatialAttribute;

	public class EntitySetConfigurationTests
	{
		
		[Test]
		public function configuration_matches_matching_entity():void
		{
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addAttribute(new SpatialAttribute());
			entity.addAttribute(new RenderAttribute());

			var configuration:EntitySetConfiguration = new EntitySetConfiguration();
			configuration.add("spatial", SpatialAttribute);
			configuration.add("render", RenderAttribute);
			
			assertTrue(configuration.matchesConfiguration(entity));
		}
		
		[Test]
		public function configuration_doesnt_match_non_matching_entity():void
		{
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addAttribute(new SpatialAttribute());

			var configuration:EntitySetConfiguration = new EntitySetConfiguration();
			configuration.add("spatial", SpatialAttribute);
			configuration.add("render", RenderAttribute);
			
			assertFalse(configuration.matchesConfiguration(entity));
		}
		
		[Test]
		public function configuration_will_configure_node():void
		{
			var render:RenderAttribute = new RenderAttribute();
			var spatial:SpatialAttribute = new SpatialAttribute();
			
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addAttribute(spatial);
			entity.addAttribute(render);

			var configuration:EntitySetConfiguration = new EntitySetConfiguration();
			configuration.add("spatial", SpatialAttribute);
			configuration.add("render", RenderAttribute);

			var node:RenderNode = new RenderNode();
			configuration.configureNode(node, entity);
			
			assertSame(render, node.render);
			assertSame(spatial, node.spatial);
		}
		
	}
}
