package ember
{
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNull;
	import asunit.asserts.assertSame;

	import ember.mocks.RenderAttribute;
	import ember.mocks.RenderNode;
	import ember.mocks.SpatialAttribute;
	
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
			var configuration:EntitySetConfiguration = factory.getClassConfiguration(RenderNode);
			assertNotNull(configuration);
		}
		
		[Test]
		public function set_configuration_properly_configures_nodes():void
		{
			var render:RenderAttribute = new RenderAttribute();
			var spatial:SpatialAttribute = new SpatialAttribute();
			
			var entities:Entities = new Entities();
			var entity:Entity = entities.create();
			entity.addAttribute(spatial);
			entity.addAttribute(render);

			var configuration:EntitySetConfiguration = factory.getClassConfiguration(RenderNode);

			var node:RenderNode = new RenderNode();
			configuration.configureNode(node, entity);
			
			assertSame(render, node.render);
			assertSame(spatial, node.spatial);
		}
		
		[Test]
		public function a_factory_can_generate_an_entity_set():void
		{
			var spatial:SpatialAttribute = new SpatialAttribute();
			var render:RenderAttribute = new RenderAttribute();
			var entities:Entities = new Entities();

			var entity:Entity = entities.create();
			entity.addAttribute(spatial);
			entity.addAttribute(render);
			
			var entitySet:ConcreteEntitySet = factory.generateSet(RenderNode, entities.list);
			
			assertSame(entity, entitySet.head.entity);
		}
		
		[Test]
		public function a_factory_does_not_include_entities_that_do_not_satisfy_criteria():void
		{
			var spatial:SpatialAttribute = new SpatialAttribute();
			var entities:Entities = new Entities();

			var entity:Entity = entities.create();
			entity.addAttribute(spatial);
			
			var entitySet:ConcreteEntitySet = factory.generateSet(RenderNode, entities.list);
			
			assertNull(entitySet.head);
		}
		
	}
}
