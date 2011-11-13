package ember.core
{
	import ember.core.ds.BitfieldMap;

	import mocks.MockComponent;
	import mocks.MockNode;
	import mocks.MockOptionalComponent;
	import mocks.MockOptionalNode;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.sameInstance;


	public class NodesConfigTests
	{
		private var _entities:Entities;
		
		[Before]
		public function before():void
		{
			var list:Vector.<Entity> = new Vector.<Entity>();
			var bitfield:BitfieldMap = new BitfieldMap();
			var factory:NodesFactory = new NodesFactory(list);
			var nodesManager:NodesManager = new NodesManager(factory);
			
			_entities = new Entities(list, bitfield, nodesManager);
		}
		
		[After]
		public function after():void
		{
			_entities = null;
		}
		
		[Test]
		public function config_matches_matching_entity():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());

			var config:NodesConfig = new NodesConfig();
			config.requiredComponents.add("required", MockComponent);
			
			assertThat(config.requiredComponents.areComponentsIn(entity), isTrue());
		}
		
		[Test]
		public function config_doesnt_match_non_matching_entity():void
		{
			var entity:Entity = _entities.create();

			var config:NodesConfig = new NodesConfig();
			config.requiredComponents.add("required", MockComponent);
			
			assertThat(config.requiredComponents.areComponentsIn(entity), isFalse());
		}
		
		[Test]
		public function optional_component_isnt_required_for_match():void
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());
			
			var config:NodesConfig = new NodesConfig();
			config.nodeClass = MockOptionalNode;
			config.requiredComponents.add("required", MockComponent);
			config.optionalComponents.add("optional", MockOptionalComponent);
			
			assertThat(config.requiredComponents.areComponentsIn(entity), isTrue());
		}
		
		
		[Test]
		public function config_will_generate_node_from_entity():void
		{
			var required:MockComponent = new MockComponent();
			
			var entity:Entity = _entities.create();
			entity.addComponent(required);

			var config:NodesConfig = new NodesConfig();
			config.nodeClass = MockNode;
			config.requiredComponents.add("required", MockComponent);

			var node:MockNode = config.generateNode(entity);
			
			assertThat(node.required, sameInstance(required));
		}
		
		[Test]
		public function generated_node_includes_optional_components():void
		{
			var required:MockComponent = new MockComponent();
			var optional:MockOptionalComponent = new MockOptionalComponent();
			
			var entity:Entity = _entities.create();
			entity.addComponent(required);
			entity.addComponent(optional);

			var config:NodesConfig = new NodesConfig();
			config.nodeClass = MockOptionalNode;
			config.requiredComponents.add("required", MockComponent);
			config.optionalComponents.add("optional", MockOptionalComponent);

			var node:MockOptionalNode = config.generateNode(entity);
			assertThat(node.optional, sameInstance(optional));
		}
		
	}
}