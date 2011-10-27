package ember.core
{
	import mocks.MockComponent;

	import org.hamcrest.assertThat;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.core.not;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.sameInstance;
	
	public class EntitiesTests
	{
		private static const BRIAN:String = "brian";
		
		private var _entities:Entities;
		
		[Before]
		public function before():void
		{
			_entities = new Entities();
		}
		
		[After]
		public function after():void
		{
			_entities = null;
		}
		
		[Test]
		public function can_create_entity():void
		{
			var entity:Entity = _entities.create();
			assertThat(_entities.contains(entity), isTrue());
		}
		
		[Test]
		public function can_remove_entity():void
		{
			var entity:Entity = _entities.create();
			_entities.remove(entity);
			assertThat(_entities.contains(entity), isFalse());
		}
		
		[Test]
		public function can_create_named_entity():void
		{
			var entity:Entity = _entities.create(BRIAN);
			assertThat(_entities.contains(entity), isTrue());
		}
		
		[Test]
		public function can_reference_named_entity():void
		{
			var entity:Entity = _entities.create(BRIAN);
			assertThat(entity, sameInstance(_entities.get(BRIAN)));
		}
		
		[Test]
		public function cannot_duplicate_entity_names():void
		{
			_entities.create(BRIAN);
			assertThat(duplicates_entity_name, throws(Error));
		}
		private function duplicates_entity_name():void
		{
			_entities.create(BRIAN);
		}
		
		[Test]
		public function can_reuse_name_after_named_entity_is_deleted():void
		{
			var entity:Entity = _entities.create(BRIAN);
			_entities.remove(entity);
			assertThat(entity, not(_entities.create(BRIAN)));
		}
		
		[Test]
		public function can_get_a_vector_of_all_entities():void
		{
			var a:Entity = _entities.create();
			var b:Entity = _entities.create();
			assertThat(_entities.getAll(), hasItems(a, b));
		}
		
		[Test]
		public function getEntities_does_not_expose_inner_list():void
		{
			var a:Entity = _entities.create();
			
			var list:Vector.<Entity> = _entities.getAll();
			list.shift();
			list = _entities.getAll();
			
			assertThat(_entities.getAll(), hasItem(a));
		}
		
		[Test]
		public function all_entities_can_be_removed_easily():void
		{
			var a:Entity = _entities.create();
			
			_entities.removeAll();
			
			assertThat(_entities.contains(a), isFalse());
		}
		
		[Test]
		public function clone_is_new_reference():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());
			var clone:Entity = _entities.clone( entity );
			assertThat(clone == entity, isFalse());
		}
		
		[Test]
		public function clone_has_child_component():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());
			var clone:Entity = _entities.clone( entity );
			assertThat(clone.hasComponent(MockComponent), isTrue());
		}
		
		[Test]
		public function clone_child_component_is_new_reference():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());
			var clone:Entity = _entities.clone( entity );
			assertThat(clone.getComponent(MockComponent) == entity.getComponent(MockComponent), isFalse());
		}
		
		[Test]
		public function clone_child_component_has_same_properties():void
		{
			var entity:Entity = _entities.create();
			var component : MockComponent = new MockComponent();
			component.n = 5;
			entity.addComponent(component);
			var clone:Entity = _entities.clone( entity );
			assertThat(clone.getComponent(MockComponent).n, equalTo(5));
		}
	}
}
