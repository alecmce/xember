package ember
{
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNotSame;
	import asunit.asserts.assertNull;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;

	import ember.mocks.RenderAttribute;
	import ember.mocks.RenderNode;
	import ember.mocks.SpatialAttribute;

	public class EntitySetTests
	{
		private var sets:EntitySets;
		private var _entities:Entities;
		
		[Before]
		public function before():void
		{
			_entities = new Entities();
			sets = new EntitySets(_entities);
		}
		
		[After]
		public function after():void
		{
			_entities = null;
			sets = null;
		}
		
		[Test]
		public function you_create_a_set_by_node_class():void
		{
			var entitySet:ConcreteEntitySet = sets.get(RenderNode);
			assertNotNull(entitySet);
		}
		
		[Test]
		public function a_set_contains_a_node_that_represents_each_member_entity():void
		{
			var spatial:SpatialAttribute = new SpatialAttribute();
			var render:RenderAttribute = new RenderAttribute();

			var entity:Entity = _entities.create();
			entity.addAttribute(spatial);
			entity.addAttribute(render);
			
			var entitySet:ConcreteEntitySet = sets.get(RenderNode);
			
			assertSame(entity, entitySet.head.entity);
		}
		
		[Test]
		public function a_set_does_not_contain_a_node_that_misses_attribute():void
		{
			var spatial:SpatialAttribute = new SpatialAttribute();

			var entity:Entity = _entities.create();
			entity.addAttribute(spatial);
			
			var entitySet:ConcreteEntitySet = sets.get(RenderNode);
			
			assertNull(entitySet.head);
		}
		
		[Test]
		public function if_an_enitities_attributes_no_longer_satisfy_set_it_is_removed():void
		{
			var spatial:SpatialAttribute = new SpatialAttribute();
			var render:RenderAttribute = new RenderAttribute();

			var entity:Entity = _entities.create();
			entity.addAttribute(spatial);
			entity.addAttribute(render);
			
			var entitySet:ConcreteEntitySet = sets.get(RenderNode);
			entity.removeAttribute(SpatialAttribute);
			
			assertNull(entitySet.head);
		}
		
		[Test]
		public function once_a_set_is_defined_if_an_entity_later_satisfies_set_it_is_added():void
		{
			var spatial:SpatialAttribute = new SpatialAttribute();
			var render:RenderAttribute = new RenderAttribute();

			var entity:Entity = _entities.create();
			entity.addAttribute(spatial);
			entity.addAttribute(render);
			
			var entitySet:ConcreteEntitySet = sets.get(RenderNode);
			
			assertSame(entity, entitySet.head.entity);
		}
		
		[Test]
		public function more_than_one_entity_can_be_added_to_a_set():void
		{
			var spatial:SpatialAttribute = new SpatialAttribute();
			var render:RenderAttribute = new RenderAttribute();

			var a:Entity = _entities.create();
			a.addAttribute(spatial);
			a.addAttribute(render);
			
			var b:Entity = _entities.create();
			b.addAttribute(spatial);
			b.addAttribute(render);
			
			var entitySet:ConcreteEntitySet = sets.get(RenderNode);
			
			var node:Node = entitySet.head;
			assertTrue(node.entity == a || node.entity == b);
			
			node = node.next;
			assertNotNull(node);
			assertTrue(node.entity == a || node.entity == b);
			assertNotSame(node.entity, entitySet.head.entity);
		}
		
		[Test]
		public function when_a_node_is_created_attributes_are_copied_into_the_node():void
		{
			var spatial:SpatialAttribute = new SpatialAttribute();
			var render:RenderAttribute = new RenderAttribute();

			var entity:Entity = _entities.create();
			entity.addAttribute(spatial);
			entity.addAttribute(render);
			
			var entitySet:ConcreteEntitySet = sets.get(RenderNode);

			var node:RenderNode = entitySet.head as RenderNode;
			assertSame(spatial, node.spatial);
			assertSame(render, node.render);
		}
		
	}
	
}
