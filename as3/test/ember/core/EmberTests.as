package ember.core
{
	import asunit.asserts.assertNull;

	import mocks.MockComponent;
	import mocks.MockNode;
	import mocks.MockSystem;

	import org.hamcrest.assertThat;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.sameInstance;
	import org.robotlegs.adapters.SwiftSuspendersInjector;

	public class EmberTests
	{
		private var _ember:Ember;
		
		[Before]
		public function before():void
		{
			var injector:SwiftSuspendersInjector = new SwiftSuspendersInjector();
			_ember = new Ember(injector);
		}
		
		[After]
		public function after():void
		{
			_ember = null;
		}
		
		[Test]
		public function can_create_entity():void
		{
			var entity:Entity = _ember.createEntity();
			assertThat(_ember.containsEntity(entity), isTrue());
		}
		
		[Test]
		public function can_remove_entity():void
		{
			var entity:Entity = _ember.createEntity();
			_ember.removeEntity(entity);
			assertThat(_ember.containsEntity(entity), isFalse());
		}
		
		[Test]
		public function can_add_a_system():void
		{
			_ember.addSystem(MockSystem);
			assertThat(_ember.hasSystem(MockSystem), isTrue());
		}
		
		[Test]
		public function can_get_an_added_system():void
		{
			_ember.addSystem(MockSystem);
			assertThat(_ember.getSystem(MockSystem), isA(MockSystem));
		}
		
		[Test]
		public function can_remove_a_system():void
		{
			_ember.addSystem(MockSystem);
			_ember.removeSystem(MockSystem);
			assertThat(_ember.hasSystem(MockSystem), isFalse());
		}
		
		[Test]
		public function if_you_add_an_already_added_system_an_error_is_thrown():void
		{
			_ember.addSystem(MockSystem);
			assertThat(addMockSystem, throws(Error));
		}
		private function addMockSystem():void
		{
			_ember.addSystem(MockSystem);
		}
		
		[Test]
		public function when_a_system_is_added_onRegister_is_called():void
		{
			var mock:MockSystem = _ember.addSystem(MockSystem) as MockSystem;
			assertThat(mock.wasRegistered, isTrue());
		}
		
		[Test]
		public function when_a_system_is_removed_onRemove_is_called():void
		{
			var mock:MockSystem = _ember.addSystem(MockSystem) as MockSystem;
			_ember.removeSystem(MockSystem);
			assertThat(mock.wasRemoved, isTrue());
		}
		
		[Test]
		public function can_get_a_vector_of_all_entities():void
		{
			var a:Entity = _ember.createEntity();
			var b:Entity = _ember.createEntity();
			assertThat(_ember.getEntities(), hasItems(a, b));
		}
		
		[Test]
		public function can_name_an_entity():void
		{
			var entity:Entity = _ember.createEntity("brian");
			assertThat(_ember.containsEntity(entity), isTrue());
		}
		
		[Test]
		public function can_reference_entity_by_name():void
		{
			var entity:Entity = _ember.createEntity("brian");
			assertThat(_ember.getEntity("brian"), sameInstance(entity));
		}
		
		[Test]
		public function can_get_an_empty_nodes_collection():void
		{
			assertThat(_ember.getNodes(MockNode), notNullValue());
		}
		
		[Test]
		public function entity_sets_are_not_duplicated():void
		{
			var nodes:Nodes = _ember.getNodes(MockNode);
			assertThat(nodes, sameInstance(_ember.getNodes(MockNode)));
		}
		
		[Test]
		public function all_entities_can_be_removed_easily():void
		{
			var a:Entity = _ember.createEntity();
			_ember.removeAllEntities();
			assertThat(_ember.containsEntity(a), isFalse());
		}
		
		[Test]
		public function removing_all_entities_empties_all_nodes_too():void
		{
			var a:Entity = _ember.createEntity();
			a.addComponent(new MockComponent());
			
			var b:Entity = _ember.createEntity();
			b.addComponent(new MockComponent());

			var nodes:Nodes = _ember.getNodes(MockNode);
			_ember.removeAllEntities();
			assertNull(nodes.head);
		}
		
	}
}