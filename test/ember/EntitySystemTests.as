package ember
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNull;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;

	import ember.mocks.MockRenderNode;
	import ember.mocks.MockRenderSystem;
	import ember.mocks.MockSpatialComponent;
	import ember.mocks.MockSpatialNode;
	import ember.mocks.MockSystem;

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
			assertTrue(system.containsEntity(entity));
		}
		
		[Test]
		public function can_remove_entity():void
		{
			var entity:Entity = system.createEntity();
			system.removeEntity(entity);
			assertFalse(system.containsEntity(entity));
		}
		
		[Test]
		public function can_add_a_system():void
		{
			system.addSystem(MockRenderSystem);
		}
		
		[Test]
		public function can_get_a_vector_of_all_entities():void
		{
			assertNotNull(system.getEntities());
		}
		
		[Test]
		public function getEntities_returns_all_generated_entities():void
		{
			var a:Entity = system.createEntity();
			var b:Entity = system.createEntity();

			var entities:Vector.<Entity> = system.getEntities();
			assertSame(a, entities[0]);
			assertSame(b, entities[1]);
		}
		
		[Test]
		public function can_add_a_nodeless_system():void
		{
			system.addSystem(MockSystem);
		}
		
		[Test]
		public function can_name_an_entity():void
		{
			var entity:Entity = system.createEntity(BRIAN);
			assertTrue(system.containsEntity(entity));
		}
		
		[Test]
		public function can_reference_entity_by_name():void
		{
			var entity:Entity = system.createEntity(BRIAN);
			var referenced:Entity = system.getEntity(BRIAN);
			
			assertSame(entity, referenced);
		}
		
		[Test]
		public function can_get_entity_set_on_demand():void
		{
			var entitySet:Nodes = system.getNodes(MockRenderNode);
			assertNotNull(entitySet);
		}
		
		[Test]
		public function entity_sets_are_not_duplicated():void
		{
			var a:Nodes = system.getNodes(MockRenderNode);
			var b:Nodes = system.getNodes(MockRenderNode);
			assertSame(a, b);
		}
		
		[Test]
		public function all_entities_can_be_removed_easily():void
		{
			var a:Entity = system.createEntity();
			var b:Entity = system.createEntity();
			
			system.removeAllEntities();
			
			assertFalse(system.containsEntity(a));
			assertFalse(system.containsEntity(b));
		}
		
		[Test]
		public function removing_all_entities_empties_all_nodes_too():void
		{
			var a:Entity = system.createEntity();
			a.addComponent(new MockSpatialComponent());
			var b:Entity = system.createEntity();
			b.addComponent(new MockSpatialComponent());

			var nodes:Nodes = system.getNodes(MockSpatialNode);
			assertSame(a, (nodes.head as MockSpatialNode).entity);
			
			system.removeAllEntities();
			assertNull(nodes.head);
		}
		
	}
}
