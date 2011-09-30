package ember.core
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import tomsbunnies.components.SpatialComponent;



	public class EntityTests
	{
		
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
		public function can_add_component_to_entity():void
		{
			var entity:Entity = entitySystem.createEntity();
			entity.addComponent(new SpatialComponent());
			assertTrue(entity.hasComponent(SpatialComponent));
		}
		
//		[Test]
//		public function can_add_component_to_entity_fluently():void
//		{
//			var entity:Entity = entitySystem.createEntity();
//			var fluent:Entity = entity.addComponent(new SpatialComponent());
//			assertSame(entity, fluent);
//		}
		
		[Test]
		public function can_reference_component_instance_by_class():void
		{
			var entity:Entity = entitySystem.createEntity();
			var component:SpatialComponent = new SpatialComponent();
			
			entity.addComponent(component);
			assertSame(component, entity.getComponent(SpatialComponent));
		}
		
		[Test]
		public function can_remove_component_from_entity():void
		{
			var entity:Entity = entitySystem.createEntity();
			entity.addComponent(new SpatialComponent());
			entity.removeComponent(SpatialComponent);
			assertFalse(entity.hasComponent(SpatialComponent));
		}
		
	}
}
