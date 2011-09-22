package ember
{
	internal class EntitySetConfiguration
	{
		
		private var _nodeNames:Vector.<String>;
		private var _attributes:Vector.<Class>;
		private var _count:uint;

		public function EntitySetConfiguration()
		{
			_nodeNames = new Vector.<String>();
			_attributes = new Vector.<Class>();
			_count = 0;
		}
		
		public function add(nodeName:String, attribute:Class):void
		{
			_nodeNames.push(nodeName);
			_attributes.push(attribute);
			++_count;
		}
		
		public function matchesConfiguration(entity:Entity):Boolean
		{
			var i:int = _attributes.length;
			while (i--)
			{
				if (!entity.hasAttribute(_attributes[i]))
					return false;
			}
			
			return true;
		}
		
		public function configureNode(node:Node, entity:Entity):void
		{
			node.entity = entity;
			
			var i:int = _count;
			while (i--)
			{
				var nodeName:String = _nodeNames[i];
				var attribute:Class = _attributes[i];
				var value:Object = entity.getAttribute(attribute);
				node[nodeName] = value;
			}
		}

		public function contains(attribute:Class):Boolean
		{
			return _attributes.indexOf(attribute) != -1;
		}
		
	}
}
