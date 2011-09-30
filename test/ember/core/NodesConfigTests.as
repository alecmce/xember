package ember.core
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;
	import mocks.MockRenderComponent;
	import mocks.MockRenderNode;
	import mocks.MockSpatialComponent;


	public class NodesConfigTests
	{
		
		[Test]
		public function config_matches_matching_entity():void
		{
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(new MockSpatialComponent());
			entity.addComponent(new MockRenderComponent());

			var config:NodesConfig = new NodesConfig();
			config.add("spatial", MockSpatialComponent);
			config.add("render", MockRenderComponent);
			
			assertTrue(config.matchesConfiguration(entity));
		}
		
		[Test]
		public function config_doesnt_match_non_matching_entity():void
		{
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(new MockSpatialComponent());

			var config:NodesConfig = new NodesConfig();
			config.add("spatial", MockSpatialComponent);
			config.add("render", MockRenderComponent);
			
			assertFalse(config.matchesConfiguration(entity));
		}
		
		[Test]
		public function config_will_generate_node_from_entity():void
		{
			var render:MockRenderComponent = new MockRenderComponent();
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);

			var config:NodesConfig = new NodesConfig();
			config.nodeClass = MockRenderNode;
			config.add("spatial", MockSpatialComponent);
			config.add("render", MockRenderComponent);

			var node:MockRenderNode = config.generateNode(entity);
			
			assertNotNull(node);
			assertSame(render, node.render);
			assertSame(spatial, node.spatial);
		}
		
	}
}
