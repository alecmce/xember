package ember.core
{
	final internal class NodesConfig
	{
		
		private var _nodeNames:Vector.<String>;
		private var _components:Vector.<Class>;
		private var _count:uint;
		
		public var nodeClass:Class;
		public var entityField:String;

		public function NodesConfig()
		{
			_nodeNames = new Vector.<String>();
			_components = new Vector.<Class>();
			_count = 0;
		}
		
		public function add(nodeName:String, component:Class):void
		{
			_nodeNames.push(nodeName);
			_components.push(component);
			++_count;
		}
		
		public function matchesConfiguration(entity:Entity):Boolean
		{
			var i:int = _components.length;
			while (i--)
			{
				if (!entity.hasComponent(_components[i]))
					return false;
			}
			
			return true;
		}
		
		public function generateNode(entity:Entity):*
		{
			var node:* = new nodeClass();
			
			if (entityField)
				node[entityField] = entity;
			
			var i:int = _count;
			while (i--)
			{
				var nodeName:String = _nodeNames[i];
				var component:Class = _components[i];
				var value:Object = entity.getComponent(component);
				node[nodeName] = value;
			}
			
			return node;
		}

		public function contains(component:Class):Boolean
		{
			return _components.indexOf(component) != -1;
		}
		
	}
}
