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

	public class GameTests
	{
		private var _game:Game;
		
		[Before]
		public function before():void
		{
			var injector:SwiftSuspendersInjector = new SwiftSuspendersInjector();
			_game = new Game(injector);
		}
		
		[After]
		public function after():void
		{
			_game = null;
		}
		
		[Test]
		public function can_create_entity():void
		{
			var entity:Entity = _game.createEntity();
			assertThat(_game.containsEntity(entity), isTrue());
		}
		
		[Test]
		public function can_remove_entity():void
		{
			var entity:Entity = _game.createEntity();
			_game.removeEntity(entity);
			assertThat(_game.containsEntity(entity), isFalse());
		}
		
		[Test]
		public function can_add_a_system():void
		{
			_game.addSystem(MockSystem);
			assertThat(_game.hasSystem(MockSystem), isTrue());
		}
		
		[Test]
		public function can_get_an_added_system():void
		{
			_game.addSystem(MockSystem);
			assertThat(_game.getSystem(MockSystem), isA(MockSystem));
		}
		
		[Test]
		public function can_remove_a_system():void
		{
			_game.addSystem(MockSystem);
			_game.removeSystem(MockSystem);
			assertThat(_game.hasSystem(MockSystem), isFalse());
		}
		
		[Test]
		public function if_you_add_an_already_added_system_an_error_is_thrown():void
		{
			_game.addSystem(MockSystem);
			assertThat(addMockSystem, throws(Error));
		}
		private function addMockSystem():void
		{
			_game.addSystem(MockSystem);
		}
		
		[Test]
		public function when_a_system_is_added_onRegister_is_called():void
		{
			var mock:MockSystem = _game.addSystem(MockSystem) as MockSystem;
			assertThat(mock.wasRegistered, isTrue());
		}
		
		[Test]
		public function when_a_system_is_removed_onRemove_is_called():void
		{
			var mock:MockSystem = _game.addSystem(MockSystem) as MockSystem;
			_game.removeSystem(MockSystem);
			assertThat(mock.wasRemoved, isTrue());
		}
		
		[Test]
		public function can_get_a_vector_of_all_entities():void
		{
			var a:Entity = _game.createEntity();
			var b:Entity = _game.createEntity();
			assertThat(_game.getEntities(), hasItems(a, b));
		}
		
		[Test]
		public function can_name_an_entity():void
		{
			var entity:Entity = _game.createEntity("brian");
			assertThat(_game.containsEntity(entity), isTrue());
		}
		
		[Test]
		public function can_reference_entity_by_name():void
		{
			var entity:Entity = _game.createEntity("brian");
			assertThat(_game.getEntity("brian"), sameInstance(entity));
		}
		
		[Test]
		public function can_get_an_empty_nodes_collection():void
		{
			assertThat(_game.getNodes(MockNode), notNullValue());
		}
		
		[Test]
		public function entity_sets_are_not_duplicated():void
		{
			var nodes:Nodes = _game.getNodes(MockNode);
			assertThat(nodes, sameInstance(_game.getNodes(MockNode)));
		}
		
		[Test]
		public function all_entities_can_be_removed_easily():void
		{
			var a:Entity = _game.createEntity();
			_game.removeAllEntities();
			assertThat(_game.containsEntity(a), isFalse());
		}
		
		[Test]
		public function removing_all_entities_empties_all_nodes_too():void
		{
			var a:Entity = _game.createEntity();
			a.addComponent(new MockComponent());
			
			var b:Entity = _game.createEntity();
			b.addComponent(new MockComponent());

			var nodes:Nodes = _game.getNodes(MockNode);
			_game.removeAllEntities();
			assertNull(nodes.head);
		}
		
	}
}