package ember.core
{
	import flash.utils.getDefinitionByName;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	final internal class InheritanceTree
	{
		private var _map:Dictionary;

		public function InheritanceTree()
		{
			_map = new Dictionary();
		}
		
		public function get(klass:Class):InheritanceNode
		{
			return _map[klass] || generate(klass);
		}
		
		private function generate(klass:Class):InheritanceNode
		{
			var node:InheritanceNode = _map[klass];
			if (node)
				return node;
			
			_map[klass] = node = new InheritanceNode(klass);

			var xml:XML = describeType(klass);
			
			var child:InheritanceNode = node;
			var list:XMLList = xml.factory.extendsClass.(@type != "Object");
			for each (xml in list)
			{
				klass = getDefinitionByName(xml.@type) as Class;
				var parent:InheritanceNode = _map[klass] ||= new InheritanceNode(klass);
				var children:Vector.<InheritanceNode> = parent.children ||= new Vector.<InheritanceNode>();
				children.push(child);
				
				child = parent;
			}
			
			return node;
		}
	}
}