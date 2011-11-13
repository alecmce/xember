package ember.core.ds
{
	final public class InheritanceTreeNode
	{
		public var klass:Class;
		public var children:Vector.<InheritanceTreeNode>;

		public function InheritanceTreeNode(klass:Class)
		{
			this.klass = klass;
		}
		
	}
}
