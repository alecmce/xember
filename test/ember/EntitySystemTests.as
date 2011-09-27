package ember
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;

	import ember.mocks.MockRenderNode;
	import ember.mocks.MockRenderSystem;
	import ember.mocks.MockSystem;

	import org.robotlegs.adapters.SwiftSuspendersInjector;
	
	public class EntitySystemTests
	{
		private static const BRIAN:String = "brian";
		
		private var entitySystem:EntitySystem;
		
		[Before]
		public function before():void
		{
			var injector:SwiftSuspendersInjector = new SwiftSuspendersInjector();
			entitySystem = new EntitySystem(injector);
		}
		
		[After]
		public function after():void
		{
			entitySystem = null;
		}
		
		[Test]
		public function can_create_entity():void
		{
			var entity:Entity = entitySystem.createEntity();
			assertTrue(entitySystem.containsEntity(entity));
		}
		
		[Test]
		public function can_remove_entity():void
		{
			var entity:Entity = entitySystem.createEntity();
			entitySystem.removeEntity(entity);
			assertFalse(entitySystem.containsEntity(entity));
		}
		
		[Test]
		public function can_add_a_system():void
		{
			entitySystem.addSystem(MockRenderSystem);
		}
		
		[Test]
		public function can_add_a_nodeless_system():void
		{
			entitySystem.addSystem(MockSystem);
		}
		
		[Test]
		public function can_name_an_entity():void
		{
			var entity:Entity = entitySystem.createEntity(BRIAN);
			assertTrue(entitySystem.containsEntity(entity));
		}
		
		[Test]
		public function can_reference_entity_by_name():void
		{
			var entity:Entity = entitySystem.createEntity(BRIAN);
			var referenced:Entity = entitySystem.getEntity(BRIAN);
			
			assertSame(entity, referenced);
		}
		
		[Test]
		public function can_get_entity_set_on_demand():void
		{
			var entitySet:Nodes = entitySystem.getSet(MockRenderNode);
			assertNotNull(entitySet);
		}
		
		[Test]
		public function entity_sets_are_not_duplicated():void
		{
			var a:Nodes = entitySystem.getSet(MockRenderNode);
			var b:Nodes = entitySystem.getSet(MockRenderNode);
			assertSame(a, b);
		}
		
	}
}
