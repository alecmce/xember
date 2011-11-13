package ember.core.ds
{
	import flash.utils.getDefinitionByName;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	final public class InheritanceTree
	{
		private var _map:Dictionary;

		public function InheritanceTree()
		{
			_map = new Dictionary();
		}
		
		public function get(klass:Class):InheritanceTreeNode
		{
			return _map[klass] || generate(klass);
		}
		
		private function generate(klass:Class):InheritanceTreeNode
		{
			var node:InheritanceTreeNode = _map[klass];
			if (node)
				return node;
			
			_map[klass] = node = new InheritanceTreeNode(klass);

			var xml:XML = describeType(klass);
			
			var child:InheritanceTreeNode = node;
			var list:XMLList = xml.factory.extendsClass.(@type != "Object");
			for each (xml in list)
			{
				klass = getDefinitionByName(xml.@type) as Class;
				var parent:InheritanceTreeNode = _map[klass] ||= new InheritanceTreeNode(klass);
				var children:Vector.<InheritanceTreeNode> = parent.children ||= new Vector.<InheritanceTreeNode>();
				children.push(child);
				
				child = parent;
			}
			
			return node;
		}
	}
}