package ember.core
{
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNull;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertThrows;
	import flash.display.Sprite;
	import mocks.MockEntityLessNode;
	import mocks.MockRenderComponent;
	import mocks.MockRenderNode;
	import mocks.MockSpatialComponent;


	
	public class NodesFactoryTests
	{
		private var factory:NodesFactory;
		
		[Before]
		public function before():void
		{
			factory = new NodesFactory();
		}
		
		[After]
		public function after():void
		{
			factory = null;
		}
		
		[Test]
		public function a_factory_can_get_set_config():void
		{
			var config:NodesConfig = factory.getClassConfiguration(MockRenderNode);
			assertNotNull(config);
		}
		
		[Test]
		public function config_will_throw_error_if_non_node_is_passed_as_class():void
		{
			assertThrows(Error, throwing_method);
		}
		private function throwing_method():void
		{
			factory.getClassConfiguration(Sprite);
		}
		
		[Test]
		public function a_node_doesnt_need_an_entity_reference_to_be_a_node():void
		{
			var config:NodesConfig = factory.getClassConfiguration(MockEntityLessNode);
			assertNotNull(config);
		}
		
		[Test]
		public function config_has_node_class_injected():void
		{
			var config:NodesConfig = factory.getClassConfiguration(MockRenderNode);
			assertSame(MockRenderNode, config.nodeClass);
		}
		
		[Test]
		public function config_properly_configures_nodes():void
		{
			var render:MockRenderComponent = new MockRenderComponent();
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);

			var config:NodesConfig = factory.getClassConfiguration(MockRenderNode);

			var node:MockRenderNode = config.generateNode(entity);
			
			assertSame(render, node.render);
			assertSame(spatial, node.spatial);
		}
		
		[Test]
		public function a_factory_can_generate_nodes():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var render:MockRenderComponent = new MockRenderComponent();
			var entities:Entities = new Entities();

			var entity:Entity = entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);
			
			var nodes:Nodes = factory.generateSet(MockRenderNode, entities.list);
			assertSame(entity, nodes.head.entity);
		}
		
		[Test]
		public function a_factory_does_not_include_entities_that_do_not_satisfy_criteria():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var entities:Entities = new Entities();

			var entity:Entity = entities.create();
			entity.addComponent(spatial);
			
			var entitySet:Nodes = factory.generateSet(MockRenderNode, entities.list);
			
			assertNull(entitySet.head);
		}
		
	}
}
