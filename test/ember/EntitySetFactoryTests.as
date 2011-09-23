package ember
{
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNull;
	import asunit.asserts.assertSame;

	import ember.mocks.MockRenderComponent;
	import ember.mocks.MockRenderNode;
	import ember.mocks.MockSpatialComponent;
	
	public class EntitySetFactoryTests
	{
		private var factory:EntitySetFactory;
		
		[Before]
		public function before():void
		{
			factory = new EntitySetFactory();
		}
		
		[After]
		public function after():void
		{
			factory = null;
		}
		
		[Test]
		public function a_factory_can_get_set_configuration():void
		{
			var configuration:EntitySetConfiguration = factory.getClassConfiguration(MockRenderNode);
			assertNotNull(configuration);
		}
		
		[Test]
		public function set_configuration_properly_configures_nodes():void
		{
			var render:MockRenderComponent = new MockRenderComponent();
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);

			var configuration:EntitySetConfiguration = factory.getClassConfiguration(MockRenderNode);

			var node:MockRenderNode = new MockRenderNode();
			configuration.configureNode(node, entity);
			
			assertSame(render, node.render);
			assertSame(spatial, node.spatial);
		}
		
		[Test]
		public function a_factory_can_generate_an_entity_set():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var render:MockRenderComponent = new MockRenderComponent();
			var entities:Entities = new Entities();

			var entity:Entity = entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);
			
			var entitySet:ConcreteEntitySet = factory.generateSet(MockRenderNode, entities.list);
			
			assertSame(entity, entitySet.head.entity);
		}
		
		[Test]
		public function a_factory_does_not_include_entities_that_do_not_satisfy_criteria():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var entities:Entities = new Entities();

			var entity:Entity = entities.create();
			entity.addComponent(spatial);
			
			var entitySet:ConcreteEntitySet = factory.generateSet(MockRenderNode, entities.list);
			
			assertNull(entitySet.head);
		}
		
	}
}
