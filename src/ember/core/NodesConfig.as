package ember.core
{
	final internal class NodesConfig
	{
		
		private var _required:NodeConfigComponentsList;
		private var _optional:NodeConfigComponentsList;
		
		public var nodeClass:Class;
		public var entityField:String;

		public function NodesConfig()
		{
			_required = new NodeConfigComponentsList();
			_optional = new NodeConfigComponentsList();
		}
		
		public function get requiredComponents():NodeConfigComponentsList
		{
			return _required;
		}

		public function get optionalComponents():NodeConfigComponentsList
		{
			return _optional;
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
