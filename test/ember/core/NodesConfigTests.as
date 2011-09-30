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
			config.requiredComponents.add("spatial", MockSpatialComponent);
			config.requiredComponents.add("render", MockRenderComponent);
			
			assertTrue(config.requiredComponents.areComponentsIn(entity));
		}
		
		[Test]
		public function config_doesnt_match_non_matching_entity():void
		{
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(new MockSpatialComponent());

			var config:NodesConfig = new NodesConfig();
			config.requiredComponents.add("spatial", MockSpatialComponent);
			config.requiredComponents.add("render", MockRenderComponent);
			
			assertFalse(config.requiredComponents.areComponentsIn(entity));
		}
		
		[Test]
		public function optional_component_isnt_required_for_match():void
		{
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(new MockSpatialComponent());
			
			var config:NodesConfig = new NodesConfig();
			config.nodeClass = MockOptionalNode;
			config.requiredComponents.add("spatial", MockSpatialComponent);
			config.optionalComponents.add("render", MockRenderComponent);
			
			assertTrue(config.requiredComponents.areComponentsIn(entity));
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
			config.requiredComponents.add("spatial", MockSpatialComponent);
			config.requiredComponents.add("render", MockRenderComponent);

			var node:MockRenderNode = config.generateNode(entity);
			
			assertNotNull(node);
			assertSame(render, node.render);
			assertSame(spatial, node.spatial);
		}
		
		[Test]
		public function generated_node_includes_optional_components():void
		{
			var render:MockRenderComponent = new MockRenderComponent();
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);

			var config:NodesConfig = new NodesConfig();
			config.nodeClass = MockOptionalNode;
			config.requiredComponents.add("spatial", MockSpatialComponent);
			config.optionalComponents.add("render", MockRenderComponent);

			var node:MockOptionalNode = config.generateNode(entity);
			assertSame(spatial, node.spatial);
		}
		
	}
}
