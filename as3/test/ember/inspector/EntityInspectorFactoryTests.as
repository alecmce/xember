package ember.inspector
{
	import ember.core.Entity;
	import ember.io.ComponentConfigFactory;

	import mocks.MockComponent;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.osflash.signals.Signal;
	
	public class EntityInspectorFactoryTests
	{
		private var configs:ComponentConfigFactory;
		private var components:ComponentInspectorFactory;
		private var factory:EntityInspectorFactory;
		
		private var componentAdded:Signal;
		private var componentRemoved:Signal;
		
		[Before]
		public function before():void
		{
			configs = new ComponentConfigFactory();
			components = new ComponentInspectorFactory(configs);
			factory = new EntityInspectorFactory(components);
			
			componentAdded = new Signal();
			componentRemoved = new Signal();
		}
		
		[After]
		public function after():void
		{
			factory = null;
			components = null;
			configs = null;
			
			componentAdded = null;
			componentRemoved = null;
		}
		
		[Test]
		public function can_get_an_entity_inspector():void
		{
			var entity:Entity = new Entity("test", componentAdded, componentRemoved);
			var inspector:EntityInspector = factory.getInspector(entity);
			
			assertThat(inspector, instanceOf(EntityInspector));
		}
		
		[Test]
		public function entity_inspector_contains_a_component_inspector_for_each_component_in_entity():void
		{
			var entity:Entity = new Entity("test", componentAdded, componentRemoved);
			entity.addComponent(new MockComponent());
			
			var inspector:EntityInspector = factory.getInspector(entity);
			
			assertThat(inspector.getComponent("mocks::MockComponent"), instanceOf(ComponentInspector));
		}
		
	}
}
