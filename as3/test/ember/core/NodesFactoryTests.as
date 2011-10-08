package ember.core
{
	import flash.display.Sprite;
	import mocks.MockComponent;
	import mocks.MockIgnoredComponent;
	import mocks.MockNode;
	import mocks.MockOptionalComponent;
	import mocks.MockOptionalNode;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.sameInstance;




	public class NodesFactoryTests
	{
		private var _entities:Entities;
		private var _factory:NodesFactory;
		
		[Before]
		public function before():void
		{
			_entities = new Entities();
			_factory = new NodesFactory();
		}
		
		[After]
		public function after():void
		{
			_entities = null;
			_factory = null;
		}
		
		[Test]
		public function a_factory_can_get_set_config():void
		{
			assertThat(_factory.getClassConfiguration(MockNode), notNullValue());
		}
		
		[Test]
		public function a_variable_flagged_as_required_is_required_in_config_definition():void
		{
			var config:NodesConfig = _factory.getClassConfiguration(MockNode);
			assertThat(config.requiredComponents.contains(MockComponent), isTrue());
		}
		
		[Test]
		public function a_variable_flagged_as_optional_is_optional_in_config_definition():void
		{
			var config:NodesConfig = _factory.getClassConfiguration(MockOptionalNode);
			assertThat(config.optionalComponents.contains(MockOptionalComponent), isTrue());
		}
		
		[Test]
		public function an_unflagged_variable_is_not_required_in_config_definition():void
		{
			var config:NodesConfig = _factory.getClassConfiguration(MockOptionalNode);
			assertThat(config.requiredComponents.contains(MockIgnoredComponent), isFalse());
		}
		
		[Test]
		public function an_unflagged_variable_is_not_optional_in_config_definition():void
		{
			var config:NodesConfig = _factory.getClassConfiguration(MockOptionalNode);
			assertThat(config.optionalComponents.contains(MockIgnoredComponent), isFalse());
		}
		
		[Test]
		public function config_has_node_class_injected():void
		{
			var config:NodesConfig = _factory.getClassConfiguration(MockNode);
			assertThat(config.nodeClass, sameInstance(MockNode));
		}
		
		[Test]
		public function required_components_are_injected_when_node_is_generated():void
		{
			var entity:Entity = _entities.create();
			var required:MockComponent = new MockComponent();
			entity.addComponent(required);

			var config:NodesConfig = _factory.getClassConfiguration(MockNode);

			var node:MockNode = config.generateNode(entity);
			assertThat(node.required, sameInstance(required));
		}
		
		[Test]
		public function optional_components_are_injected_when_node_is_generated():void
		{
			var optional:MockOptionalComponent = new MockOptionalComponent();
			
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());
			entity.addComponent(optional);

			var config:NodesConfig = _factory.getClassConfiguration(MockOptionalNode);

			var node:MockOptionalNode = config.generateNode(entity);
			assertThat(node.optional, sameInstance(optional));
		}
		
		[Test]
		public function generateSet_will_generate_one_node_for_each_entity():void
		{
			for (var i:int = 0; i < 5; i++)
				createEntity();

			var nodes:Nodes = _factory.generateSet(MockNode, _entities.list);
			assertThat(nodes.count, equalTo(5));
		}
		private function createEntity():Entity
		{
			var entity:Entity = _entities.create();
			entity.addComponent(new MockComponent());
			return entity;
		}
		
		[Test]
		public function a_factory_does_not_include_entities_that_do_not_satisfy_criteria():void
		{
			_entities.create();
			
			var nodes:Nodes = _factory.generateSet(MockNode, _entities.list);
			assertThat(nodes.count, equalTo(0));
		}
		
		[Test]
		public function config_will_throw_error_if_non_node_is_passed_as_class():void
		{
			assertThat(throwing_method, throws(Error));
		}
		private function throwing_method():void
		{
			_factory.getClassConfiguration(Sprite);
		}
		
	}
}