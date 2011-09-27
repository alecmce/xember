package ember
{
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNull;
	import asunit.asserts.assertSame;

	import ember.mocks.MockRenderComponent;
	import ember.mocks.MockRenderNode;
	import ember.mocks.MockSpatialComponent;

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
			var entitySet:ConcreteEntitySet = sets.get(MockRenderNode);
			assertNotNull(entitySet);
		}
		
		[Test]
		public function a_set_contains_a_node_that_represents_each_member_entity():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var render:MockRenderComponent = new MockRenderComponent();

			var entity:Entity = _entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);
			
			var entitySet:ConcreteEntitySet = sets.get(MockRenderNode);
			
			assertSame(entity, entitySet.head.entity);
		}
		
		[Test]
		public function a_set_does_not_contain_a_node_that_misses_component():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();

			var entity:Entity = _entities.create();
			entity.addComponent(spatial);
			
			var entitySet:ConcreteEntitySet = sets.get(MockRenderNode);
			
			assertNull(entitySet.head);
		}
		
		[Test]
		public function if_an_enitities_components_no_longer_satisfy_set_it_is_removed():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var render:MockRenderComponent = new MockRenderComponent();

			var entity:Entity = _entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);
			
			var entitySet:ConcreteEntitySet = sets.get(MockRenderNode);
			entity.removeComponent(MockSpatialComponent);
			
			assertNull(entitySet.head);
		}
		
		[Test]
		public function once_a_set_is_defined_if_an_entity_later_satisfies_set_it_is_added():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var render:MockRenderComponent = new MockRenderComponent();

			var entity:Entity = _entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);
			
			var entitySet:ConcreteEntitySet = sets.get(MockRenderNode);
			
			assertSame(entity, entitySet.head.entity);
		}
		
		[Test]
		public function more_than_one_entity_can_be_added_to_a_set():void
		{
			var aSpatial:MockSpatialComponent = new MockSpatialComponent();
			var aRender:MockRenderComponent = new MockRenderComponent();
			var a:Entity = _entities.create();
			a.addComponent(aSpatial);
			a.addComponent(aRender);
			
			var bSpatial:MockSpatialComponent = new MockSpatialComponent();
			var bRender:MockRenderComponent = new MockRenderComponent();
			var b:Entity = _entities.create();
			b.addComponent(bSpatial);
			b.addComponent(bRender);
			
			var entitySet:ConcreteEntitySet = sets.get(MockRenderNode);
			
			var node:MockRenderNode = entitySet.head as MockRenderNode;
			assertSame(aRender, node.render);
			assertSame(aSpatial, node.spatial);
			
			node = node.next;
			assertNotNull(node);
			assertSame(bRender, node.render);
			assertSame(bSpatial, node.spatial);
		}
		
		[Test]
		public function when_a_node_is_created_components_are_copied_into_the_node():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var render:MockRenderComponent = new MockRenderComponent();

			var entity:Entity = _entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);
			
			var entitySet:ConcreteEntitySet = sets.get(MockRenderNode);

			var node:MockRenderNode = entitySet.head as MockRenderNode;
			assertSame(spatial, node.spatial);
			assertSame(render, node.render);
		}
		
		[Test]
		public function entity_sets_are_not_duplicated():void
		{
			var a:EntitySet = sets.get(MockRenderNode);
			var b:EntitySet = sets.get(MockRenderNode);
			assertSame(a, b);
		}
		
	}
	
}
