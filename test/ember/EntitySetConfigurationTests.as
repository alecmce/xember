package ember
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;

	import ember.mocks.MockRenderComponent;
	import ember.mocks.MockRenderNode;
	import ember.mocks.MockSpatialComponent;

	public class EntitySetConfigurationTests
	{
		
		[Test]
		public function configuration_matches_matching_entity():void
		{
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(new MockSpatialComponent());
			entity.addComponent(new MockRenderComponent());

			var configuration:EntitySetConfiguration = new EntitySetConfiguration();
			configuration.add("spatial", MockSpatialComponent);
			configuration.add("render", MockRenderComponent);
			
			assertTrue(configuration.matchesConfiguration(entity));
		}
		
		[Test]
		public function configuration_doesnt_match_non_matching_entity():void
		{
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(new MockSpatialComponent());

			var configuration:EntitySetConfiguration = new EntitySetConfiguration();
			configuration.add("spatial", MockSpatialComponent);
			configuration.add("render", MockRenderComponent);
			
			assertFalse(configuration.matchesConfiguration(entity));
		}
		
		[Test]
		public function configuration_will_configure_node():void
		{
			var render:MockRenderComponent = new MockRenderComponent();
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);

			var configuration:EntitySetConfiguration = new EntitySetConfiguration();
			configuration.add("spatial", MockSpatialComponent);
			configuration.add("render", MockRenderComponent);

			var node:MockRenderNode = new MockRenderNode();
			configuration.configureNode(node, entity);
			
			assertSame(render, node.render);
			assertSame(spatial, node.spatial);
		}
		
	}
}
