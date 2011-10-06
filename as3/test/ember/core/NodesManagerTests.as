package ember.core
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNull;
	import asunit.asserts.assertSame;

	import mocks.MockRenderComponent;
	import mocks.MockRenderNode;
	import mocks.MockSpatialComponent;
	import mocks.MockSpatialNode;


	public class NodesManagerTests
	{
		private var _entities:Entities;
		private var _manager:NodesManager;
		
		[Before]
		public function before():void
		{
			_entities = new Entities();
			_manager = new NodesManager(_entities);
		}
		
		[After]
		public function after():void
		{
			_entities = null;
			_manager = null;
		}
		
		[Test]
		public function you_create_a_set_by_node_class():void
		{
			var nodes:Nodes = _manager.get(MockRenderNode);
			assertNotNull(nodes);
		}
		
		[Test]
		public function nodes_contains_a_node_that_represents_each_member_entity():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var render:MockRenderComponent = new MockRenderComponent();

			var entity:Entity = _entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);
			
			var nodes:Nodes = _manager.get(MockRenderNode);
			
			assertSame(entity, nodes.head.entity);
		}
		
		[Test]
		public function nodes_does_not_contain_a_node_that_misses_component():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();

			var entity:Entity = _entities.create();
			entity.addComponent(spatial);
			
			var nodes:Nodes = _manager.get(MockRenderNode);
			
			assertNull(nodes.head);
		}
		
		[Test]
		public function if_an_enititys_components_no_longer_satisfy_requirements_it_is_removed():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var render:MockRenderComponent = new MockRenderComponent();

			var entity:Entity = _entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);
			
			var nodes:Nodes = _manager.get(MockRenderNode);
			entity.removeComponent(MockSpatialComponent);
			
			assertNull(nodes.head);
		}
		
		[Test]
		public function once_nodes_is_defined_if_an_entity_later_satisfies_requirements_it_is_added():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var render:MockRenderComponent = new MockRenderComponent();

			var entity:Entity = _entities.create();
			entity.addComponent(spatial);
			
			var nodes:Nodes = _manager.get(MockRenderNode);
			entity.addComponent(render);
			
			assertSame(entity, nodes.head.entity);
		}
		
		[Test]
		public function more_than_one_entity_can_be_added_to_nodes():void
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
			
			var nodes:Nodes = _manager.get(MockRenderNode);
			
			var node:MockRenderNode = nodes.head as MockRenderNode;
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
			
			var nodes:Nodes = _manager.get(MockRenderNode);

			var node:MockRenderNode = nodes.head as MockRenderNode;
			assertSame(spatial, node.spatial);
			assertSame(render, node.render);
		}
		
		[Test]
		public function nodes_are_not_duplicated():void
		{
			var a:Nodes = _manager.get(MockRenderNode);
			var b:Nodes = _manager.get(MockRenderNode);
			assertSame(a, b);
		}
		
		[Test]
		public function all_nodes_are_removed_when_clear_is_called():void
		{
			var spatial:MockSpatialComponent = new MockSpatialComponent();
			var render:MockRenderComponent = new MockRenderComponent();

			var entity:Entity = _entities.create();
			entity.addComponent(spatial);
			entity.addComponent(render);
			
			var nodes:Nodes = _manager.get(MockRenderNode);
			
			_manager.clear();
			
			assertNull(nodes.head);
		}
		
		[Test]
		public function optional_component_is_added_to_existing_node_when_added_to_component():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockSpatialComponent());

			var nodes:Nodes = _manager.get(MockOptionalNode);
			
			var render:MockRenderComponent = new MockRenderComponent();
			entity.addComponent(render);
			
			assertSame(render, nodes.head.render);
		}
		
		[Test]
		public function optional_component_is_removed_from_existing_node_when_removed_from_component():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockSpatialComponent());
			
			var render:MockRenderComponent = new MockRenderComponent();
			entity.addComponent(render);

			var nodes:Nodes = _manager.get(MockOptionalNode);
			
			entity.removeComponent(MockRenderComponent);
			assertNull(nodes.head.render);
		}
		
		[Test]
		public function an_empty_nodes_reports_0_count():void
		{
			var nodes:Nodes = _manager.get(MockSpatialNode);
			assertEquals(0, nodes.count)
		}
		
		
		[Test]
		public function nodes_reports_accurate_count_after_construction():void
		{
			var count:uint = 5;
			
			for (var i:int = 0; i < count; i++)
			{
				var entity:Entity = _entities.create();
				entity.addComponent(new MockSpatialComponent());
			}

			var nodes:Nodes = _manager.get(MockSpatialNode);
			assertEquals(count, nodes.count);
		}
		
		[Test]
		public function nodes_count_is_maintained_as_entities_are_added():void
		{
			var entity:Entity, i:int;

			var count:uint = 5;
			for (i = 0; i < count; i++)
			{
				entity = _entities.create();
				entity.addComponent(new MockSpatialComponent());
			}

			var nodes:Nodes = _manager.get(MockSpatialNode);
			
			for (i = 0; i < count; i++)
			{
				entity = _entities.create();
				entity.addComponent(new MockSpatialComponent());
			}
			
			assertEquals(count * 2, nodes.count);
		}
		
		[Test]
		public function nodes_count_is_maintained_as_entities_are_removed():void
		{
			var entity:Entity, i:int;

			var count:uint = 10;
			for (i = 0; i < count; i++)
			{
				entity = _entities.create("id" + i);
				entity.addComponent(new MockSpatialComponent());
			}

			var nodes:Nodes = _manager.get(MockSpatialNode);
			
			var removed:uint = 3;
			for (i = 0; i < removed; i++)
			{
				entity = _entities.get("id" + i);
				entity.removeComponent(MockSpatialComponent);
			}
			
			assertEquals(count - removed, nodes.count);
		}
		
		[Test]
		public function when_an_entity_is_removed_any_corresponding_nodes_are_removed():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockSpatialComponent());

			var nodes:Nodes = _manager.get(MockSpatialNode);
			assertSame(entity, nodes.head.entity);
			
			_manager.removeEntity(entity);
			assertNull(nodes.head);
		}
		
	}
	
}
