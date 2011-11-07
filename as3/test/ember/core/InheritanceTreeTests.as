package ember.core
{
	import mocks.extending.MockBase;
	import mocks.extending.MockExtendsA;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.nullValue;
	import org.hamcrest.object.sameInstance;
	
	public class InheritanceTreeTests
	{
		private var tree:InheritanceTree;
		
		[Before]
		public function before():void
		{
			tree = new InheritanceTree();
		}
		
		[After]
		public function after():void
		{
			tree = null;
		}
		
		[Test]
		public function node_references_class():void
		{
			var node:InheritanceNode = tree.get(MockBase);
			assertThat(node.klass, sameInstance(MockBase));
		}
		
		[Test]
		public function getting_node_for_base_class_doesnt_generate_children():void
		{
			var node:InheritanceNode = tree.get(MockBase);
			assertThat(node.children, nullValue());
		}
		
		[Test]
		public function getting_node_for_subclass_doesnt_generate_children_for_subclass():void
		{
			var node:InheritanceNode = tree.get(MockExtendsA);
			assertThat(node.children, nullValue());
		}
		
		[Test]
		public function getting_node_for_subclass_generates_children_for_base_class():void
		{
			var node:InheritanceNode = tree.get(MockExtendsA);
			assertThat(tree.get(MockBase).children[0], sameInstance(node));
		}
		
	}
}
