package ember
{
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertTrue;
	import ember.mocks.SpatialAttribute;


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
		public function can_add_attribute_to_entity():void
		{
			var entity:Entity = entitySystem.createEntity();
			entity.addAttribute(new SpatialAttribute());
			assertTrue(entity.hasAttribute(SpatialAttribute));
		}
		
//		[Test]
//		public function can_add_attribute_to_entity_fluently():void
//		{
//			var entity:Entity = entitySystem.createEntity();
//			var fluent:Entity = entity.addAttribute(new SpatialAttribute());
//			assertSame(entity, fluent);
//		}
		
		[Test]
		public function can_reference_attribute_instance_by_class():void
		{
			var entity:Entity = entitySystem.createEntity();
			var attribute:SpatialAttribute = new SpatialAttribute();
			
			entity.addAttribute(attribute);
			assertSame(attribute, entity.getAttribute(SpatialAttribute));
		}
		
		[Test]
		public function can_remove_attribute_from_entity():void
		{
			var entity:Entity = entitySystem.createEntity();
			entity.addAttribute(new SpatialAttribute());
			entity.removeAttribute(SpatialAttribute);
			assertFalse(entity.hasAttribute(SpatialAttribute));
		}
		
	}
}
