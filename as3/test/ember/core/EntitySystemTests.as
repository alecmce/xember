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




	public class EntitySystemTests
	{
		private static const BRIAN:String = "brian";
		
		private var system:EntitySystem;
		
		[Before]
		public function before():void
		{
			var injector:SwiftSuspendersInjector = new SwiftSuspendersInjector();
			system = new EntitySystem(injector);
		}
		
		[After]
		public function after():void
		{
			system = null;
		}
		
		[Test]
		public function can_create_entity():void
		{
			var entity:Entity = system.createEntity();
			assertThat(system.containsEntity(entity), isTrue());
		}
		
		[Test]
		public function can_remove_entity():void
		{
			var entity:Entity = system.createEntity();
			system.removeEntity(entity);
			assertThat(system.containsEntity(entity), isFalse());
		}
		
		[Test]
		public function can_add_a_system():void
		{
			system.addSystem(MockSystem);
			assertThat(system.hasSystem(MockSystem), isTrue());
		}
		
		[Test]
		public function can_get_an_added_system():void
		{
			system.addSystem(MockSystem);
			assertThat(system.getSystem(MockSystem), isA(MockSystem));
		}
		
		[Test]
		public function can_remove_a_system():void
		{
			system.addSystem(MockSystem);
			system.removeSystem(MockSystem);
			assertThat(system.hasSystem(MockSystem), isFalse());
		}
		
		[Test]
		public function if_you_add_an_already_added_system_an_error_is_thrown():void
		{
			system.addSystem(MockSystem);
			assertThat(addMockSystem, throws(Error));
		}
		private function addMockSystem():void
		{
			system.addSystem(MockSystem);
		}
		
		[Test]
		public function when_a_system_is_added_onRegister_is_called():void
		{
			var mock:MockSystem = system.addSystem(MockSystem) as MockSystem;
			assertThat(mock.wasRegistered, isTrue());
		}
		
		[Test]
		public function when_a_system_is_removed_onRemove_is_called():void
		{
			var mock:MockSystem = system.addSystem(MockSystem) as MockSystem;
			system.removeSystem(MockSystem);
			assertThat(mock.wasRemoved, isTrue());
		}
		
		[Test]
		public function can_get_a_vector_of_all_entities():void
		{
			var a:Entity = system.createEntity();
			var b:Entity = system.createEntity();
			assertThat(system.getEntities(), hasItems(a, b));
		}
		
		[Test]
		public function can_name_an_entity():void
		{
			var entity:Entity = system.createEntity(BRIAN);
			assertThat(system.containsEntity(entity), isTrue());
		}
		
		[Test]
		public function can_reference_entity_by_name():void
		{
			var entity:Entity = system.createEntity(BRIAN);
			assertThat(system.getEntity(BRIAN), sameInstance(entity));
		}
		
		[Test]
		public function can_get_an_empty_nodes_collection():void
		{
			assertThat(system.getNodes(MockNode), notNullValue());
		}
		
		[Test]
		public function entity_sets_are_not_duplicated():void
		{
			var nodes:Nodes = system.getNodes(MockNode);
			assertThat(nodes, sameInstance(system.getNodes(MockNode)));
		}
		
		[Test]
		public function all_entities_can_be_removed_easily():void
		{
			var a:Entity = system.createEntity();
			system.removeAllEntities();
			assertThat(system.containsEntity(a), isFalse());
		}
		
		[Test]
		public function removing_all_entities_empties_all_nodes_too():void
		{
			var a:Entity = system.createEntity();
			a.addComponent(new MockComponent());
			
			var b:Entity = system.createEntity();
			b.addComponent(new MockComponent());

			var nodes:Nodes = system.getNodes(MockNode);
			system.removeAllEntities();
			assertNull(nodes.head);
		}
		
	}
}