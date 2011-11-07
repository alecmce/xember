package ember.core
{
	final internal class InheritanceNode
	{
		public var klass:Class;
		public var children:Vector.<InheritanceNode>;

		public function InheritanceNode(klass:Class)
		{
			this.klass = klass;
		}

		
	}
}
