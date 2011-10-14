package ember.core
{
	import mocks.MockComponent;
	import mocks.MockNode;
	import mocks.MockOptionalComponent;
	import mocks.MockOptionalNode;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	import org.hamcrest.object.sameInstance;


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
			assertThat(_manager.get(MockNode), notNullValue());
		}
		
		[Test]
		public function nodes_contains_a_node_that_represents_each_member_entity():void
		{
			var list:Array = [];
			for (var i:int = 0; i < 7; i++)
			{
				var entity:Entity = _entities.create();
				entity.addComponent(new MockComponent());
				list[i] = entity;
			}
			
			var nodes:Nodes = _manager.get(MockNode);
			var foundCount:uint = 0;
			for (var node:MockNode = nodes.head; node; node = node.next)
				list.indexOf(node.entity) != -1 && ++foundCount;
			
			assertThat(foundCount, equalTo(7));
		}
		
		[Test]
		public function nodes_does_not_contain_a_node_that_misses_component():void
		{
			for (var i:int = 0; i < 8; i++)
				_entities.create();
			
			var nodes:Nodes = _manager.get(MockNode);
			assertThat(nodes.count, equalTo(0));
		}
		
		[Test]
		public function if_an_enititys_components_no_longer_satisfy_requirements_it_is_removed():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());
			
			var nodes:Nodes = _manager.get(MockNode);
			var wasAdded:Boolean = nodes.count == 1;
			
			entity.removeComponent(MockComponent);
			var wasRemoved:Boolean = nodes.count == 0;
			
			assertThat(wasAdded && wasRemoved, isTrue());
		}
		
		[Test]
		public function once_nodes_is_defined_if_an_entity_later_satisfies_requirements_it_is_added():void
		{
			var entity:Entity = _entities.create();
			
			var nodes:Nodes = _manager.get(MockNode);
			var noNodes:Boolean = nodes.count == 0;
			
			entity.addComponent(new MockComponent());
			var nodeAdded:Boolean = nodes.count == 1;
			
			assertThat(noNodes && nodeAdded, isTrue());
		}
		
		[Test]
		public function nodes_are_not_duplicated_per_request():void
		{
			var nodes:Nodes = _manager.get(MockNode);
			assertThat(_manager.get(MockNode), sameInstance(nodes));
		}
		
		[Test]
		public function count_is_0_when_clear_is_called():void
		{
			for (var i:int = 0; i < 11; i++)
			{
				var entity:Entity = _entities.create();
				entity.addComponent(new MockComponent());
			}
			
			var nodes:Nodes = _manager.get(MockNode);
			
			_manager.clear();
			assertThat(nodes.count, equalTo(0));
		}
		
		[Test]
		public function all_nodes_are_removed_when_clear_is_called():void
		{
			for (var i:int = 0; i < 11; i++)
			{
				var entity:Entity = _entities.create();
				entity.addComponent(new MockComponent());
			}
			
			var nodes:Nodes = _manager.get(MockNode);
			
			_manager.clear();
			assertThat(nodes.head, nullValue());
		}
		
		[Test]
		public function optional_component_is_added_to_existing_node_when_added_to_component():void
		{
			var component:MockOptionalComponent = new MockOptionalComponent();
			
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());
			entity.addComponent(component);

			var nodes:Nodes = _manager.get(MockOptionalNode);
			
			assertThat(nodes.head.optional, sameInstance(component));
		}
		
		[Test]
		public function optional_component_is_removed_from_existing_node_when_removed_from_component():void
		{
			var component:MockOptionalComponent = new MockOptionalComponent();
			
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());
			entity.addComponent(component);

			var nodes:Nodes = _manager.get(MockOptionalNode);
			
			entity.removeComponent(MockOptionalComponent);
			assertThat(nodes.head.optional, nullValue());
		}
		
		[Test]
		public function an_empty_nodes_reports_0_count():void
		{
			var nodes:Nodes = _manager.get(MockNode);
			assertThat(nodes.count, equalTo(0));
		}
		
		
		[Test]
		public function nodes_reports_accurate_count_after_construction():void
		{
			for (var i:int = 0; i < 5; i++)
			{
				var entity:Entity = _entities.create();
				entity.addComponent(new MockComponent());
			}

			var nodes:Nodes = _manager.get(MockNode);
			assertThat(nodes.count, equalTo(5));
		}
		
		[Test]
		public function nodes_count_is_maintained_as_entities_are_added():void
		{
			var entity:Entity, i:int;

			var count:uint = 5;
			for (i = 0; i < count; i++)
			{
				entity = _entities.create();
				entity.addComponent(new MockComponent());
			}

			var nodes:Nodes = _manager.get(MockNode);
			
			for (i = 0; i < 3; i++)
			{
				entity = _entities.create();
				entity.addComponent(new MockComponent());
			}
			
			assertThat(nodes.count, equalTo(5 + 3));
		}
		
		[Test]
		public function nodes_count_is_maintained_as_entities_are_removed():void
		{
			var entity:Entity, i:int;

			var count:uint = 10;
			for (i = 0; i < count; i++)
			{
				entity = _entities.create("id" + i);
				entity.addComponent(new MockComponent());
			}

			var nodes:Nodes = _manager.get(MockNode);
			
			var removed:uint = 3;
			for (i = 0; i < removed; i++)
			{
				entity = _entities.get("id" + i);
				entity.removeComponent(MockComponent);
			}
			
			assertThat(nodes.count, equalTo(10 - 3));
		}
		
		[Test]
		public function a_node_can_be_referenced_in_nodes_by_entity():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());

			var nodes:Nodes = _manager.get(MockNode);
			assertThat(nodes.get(entity), notNullValue());
		}
		
		[Test]
		public function when_an_entity_is_removed_any_corresponding_nodes_are_removed():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());

			var nodes:Nodes = _manager.get(MockNode);
			_manager.removeEntity(entity);
			
			assertThat(nodes.get(entity), nullValue());
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
