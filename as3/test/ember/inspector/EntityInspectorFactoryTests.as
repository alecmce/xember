package ember.inspector
{
	import ember.core.Ember;
	import ember.core.Entity;
	import ember.io.ComponentConfigFactory;

	import mocks.MockComponent;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.nullValue;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	
	public class EntityInspectorFactoryTests
	{
		private var system:Ember;
		private var configs:ComponentConfigFactory;
		private var components:ComponentInspectorFactory;
		private var factory:EntityInspectorFactory;
		
		[Before]
		public function before():void
		{
			system = new Ember(new SwiftSuspendersInjector());
			configs = new ComponentConfigFactory();
			components = new ComponentInspectorFactory(configs);
			factory = new EntityInspectorFactory(system, components);
		}
		
		[After]
		public function after():void
		{
			system = null;
			configs = null;
			components = null;
			factory = null;
		}
		
		[Test]
		public function can_get_an_entity_inspector():void
		{
			var entity:Entity = system.createEntity();
			var inspector:EntityInspector = factory.getInspector(entity);
			
			assertThat(inspector, instanceOf(EntityInspector));
		}
		
		[Test]
		public function entity_inspector_contains_a_component_inspector_for_each_component_in_entity():void
		{
			var entity:Entity = system.createEntity();
			entity.addComponent(new MockComponent());
			
			var inspector:EntityInspector = factory.getInspector(entity);
			
			assertThat(inspector.getComponent(MockComponent), instanceOf(ComponentInspector));
		}
		
		[Test]
		public function inspector_adds_component_if_component_is_added():void
		{
			var entity:Entity = system.createEntity();
			var inspector:EntityInspector = factory.getInspector(entity);
			entity.addComponent(new MockComponent());
			
			assertThat(inspector.getComponent(MockComponent), instanceOf(ComponentInspector));
		}
		
		[Test]
		public function inspector_removes_component_if_component_is_removed():void
		{
			var entity:Entity = system.createEntity();
			entity.addComponent(new MockComponent());
			
			var inspector:EntityInspector = factory.getInspector(entity);
			entity.removeComponent(MockComponent);
			
			assertThat(inspector.getComponent(MockComponent), nullValue());
		}
		
	}
}
