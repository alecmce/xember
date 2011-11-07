package ember.core
{
	import mocks.MockComponent;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.sameInstance;
	import org.osflash.signals.Signal;

	public class EntityTests
	{
		private var added:Signal;
		private var removed:Signal;
		private var mask:ObjectMask;
		
		[Before]
		public function before():void
		{
			added = new Signal();
			removed = new Signal();
			mask = new ObjectMask();
		}
		
		[After]
		public function after():void
		{
			added = null;
			removed = null;
		}
		
		[Test]
		public function can_add_component_to_entity():void
		{
			var entity:Entity = new Entity("", added, removed);
			entity.addComponent(new MockComponent());
			assertThat(entity.hasComponent(MockComponent), isTrue());
		}
		
		[Test]
		public function can_reference_component_instance_by_class():void
		{
			var entity:Entity = new Entity("", added, removed);
			var component:MockComponent = new MockComponent();
			
			entity.addComponent(component);
			assertThat(entity.getComponent(MockComponent), sameInstance(component));
		}
		
		[Test]
		public function can_remove_component_from_entity():void
		{
			var entity:Entity = new Entity("", added, removed);
			entity.addComponent(new MockComponent());
			entity.removeComponent(MockComponent);
			assertThat(entity.hasComponent(MockComponent), isFalse());
		}
		
//		[Test]
//		public function entity_components_are_described_by_mask():void
//		{
//			var entity:Entity = new Entity("", added, removed);
//			
//		}
		
	}
}