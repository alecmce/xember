package ember.core
{
	final internal class NodesConfig
	{
		
		private var _required:NodesConfigList;
		private var _optional:NodesConfigList;
		
		public var nodeClass:Class;
		public var entityField:String;

		public function NodesConfig()
		{
			_required = new NodesConfigList();
			_optional = new NodesConfigList();
		}
		
		public function required(name:String, component:Class):void
		{
			_required.add(name, component);
		}
		
		public function isRequired(component:Class):Boolean
		{
			return _required.contains(component);
		}
		
		public function optional(name:String, component:Class):void
		{
			_optional.add(name, component);
		}
		
		public function isOptional(component:Class):Boolean
		{	
			return _optional.contains(component);
		}
		
		public function matchesConfiguration(entity:Entity):Boolean
		{
			return _required.hasConfigList(entity);
		}
		
		public function generateNode(entity:Entity):*
		{
			var node:* = new nodeClass();
			
			if (entityField)
				node[entityField] = entity;
			
			_required.populateNode(node, entity);
			_optional.populateNode(node, entity);
			
			return node;
		}
		
	}
}
