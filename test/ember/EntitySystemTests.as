package ember
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;

	import ember.mocks.NodelessSystem;
	import ember.mocks.RenderNode;
	import ember.mocks.RenderSystem;

	import org.robotlegs.adapters.SwiftSuspendersInjector;


	
	public class EntitySystemTests
	{
		private static const BRIAN:String = "brian";
		
		private var entitySystem:EntitySystem;
		
		[Before]
		public function before():void
		{
			entitySystem = new EntitySystem(new SwiftSuspendersInjector());
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
			entitySystem.addSystem(RenderSystem, RenderNode);
		}
		
		[Test]
		public function can_add_a_nodeless_system():void
		{
			entitySystem.addSystem(NodelessSystem);
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
		
	}
}
