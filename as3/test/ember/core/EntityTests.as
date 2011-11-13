package ember.core
{
	import asunit.framework.Async;

	import ember.core.ds.BitfieldMap;

	import mocks.MockComponent;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.sameInstance;



	public class EntityTests
	{
		private var list:Vector.<Entity>;
		private var bitfield:BitfieldMap;
		private var factory:NodesFactory;
		private var nodesManager:NodesManager;
		private var entities:Entities;
		
		[Inject]
		public var async:Async;
		
		[Before]
		public function before():void
		{
			list = new Vector.<Entity>();
			bitfield = new BitfieldMap();
			factory = new NodesFactory(list);
			nodesManager = new NodesManager(factory);
			entities = new Entities(list, bitfield, nodesManager);
		}
		
		[After]
		public function after():void
		{
			entities = null;
			nodesManager = null;
			factory = null;
			bitfield = null;
			list = null;
		}
		
		[Test]
		public function can_add_component_to_entity():void
		{
			var entity:Entity = new Entity("", nodesManager, bitfield);
			entity.addComponent(new MockComponent());
			assertThat(entity.hasComponent(MockComponent), isTrue());
		}
		
		[Test]
		public function can_reference_component_instance_by_class():void
		{
			var entity:Entity = new Entity("", nodesManager, bitfield);
			var component:MockComponent = new MockComponent();
			
			entity.addComponent(component);
			assertThat(entity.getComponent(MockComponent), sameInstance(component));
		}
		
		[Test]
		public function can_remove_component_from_entity():void
		{
			var entity:Entity = new Entity("", nodesManager, bitfield);
			entity.addComponent(new MockComponent());
			entity.removeComponent(MockComponent);
			assertThat(entity.hasComponent(MockComponent), isFalse());
		}
		
	}
}