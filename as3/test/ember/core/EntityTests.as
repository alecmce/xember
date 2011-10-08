package ember.core
{
	import mocks.MockComponent;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.sameInstance;
	import org.robotlegs.adapters.SwiftSuspendersInjector;



	public class EntityTests
	{
		
		private var _entitySystem:EntitySystem;
		
		[Before]
		public function before():void
		{
			_entitySystem = new EntitySystem(new SwiftSuspendersInjector());
		}
		
		[After]
		public function after():void
		{
			_entitySystem = null;
		}
		
		[Test]
		public function can_add_component_to_entity():void
		{
			var entity:Entity = _entitySystem.createEntity();
			entity.addComponent(new MockComponent());
			assertThat(entity.hasComponent(MockComponent), isTrue());
		}
		
		[Test]
		public function can_reference_component_instance_by_class():void
		{
			var entity:Entity = _entitySystem.createEntity();
			var component:MockComponent = new MockComponent();
			
			entity.addComponent(component);
			assertThat(entity.getComponent(MockComponent), sameInstance(component));
		}
		
		[Test]
		public function can_remove_component_from_entity():void
		{
			var entity:Entity = _entitySystem.createEntity();
			entity.addComponent(new MockComponent());
			entity.removeComponent(MockComponent);
			assertThat(entity.hasComponent(MockComponent), isFalse());
		}
		
	}
}