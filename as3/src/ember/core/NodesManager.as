package ember.core
{
	import flash.utils.Dictionary;

	final internal class NodesManager
	{
		private var _factory:NodesFactory;
		
		private var _nodesMap:Dictionary;
		private var _required:NodesComponentMap;
		private var _optional:NodesComponentMap;
		
		public function NodesManager(factory:NodesFactory)
		{
			_factory = factory;
			
			_nodesMap = new Dictionary();
			_required = new NodesComponentMap();
			_optional = new NodesComponentMap();
		}

		public function get(nodeClass:Class):Nodes
		{
			var nodes:Nodes = _nodesMap[nodeClass] ||= _factory.generateSet(nodeClass);
			
			var config:NodesConfig = nodes.config;
			_required.add(config.requiredComponents, nodes);
			_optional.add(config.optionalComponents, nodes);
			
			return nodes;
		}
		
		public function removeEntity(entity:Entity):void
		{
			var list:Dictionary = entity.nodes;
			
			for each (var nodes:Nodes in list)
				nodes.remove(entity);
		}

		public function clear():void
		{
			for each (var nodes:Nodes in _nodesMap)
				nodes.clear();
		}
		
		internal function componentAddedToEntity(entity:Entity, component:Class, bits:Vector.<uint>):void
		{
			var list:Vector.<Nodes>, nodes:Nodes;
			
			list = _required.getNodesFor(component);
			for each (nodes in list)
			{
				if (nodes.config.requiredComponents.areComponentsIn(entity))
					nodes.add(entity);
			}
			
			list = _optional.getNodesFor(component);
			for each (nodes in list)
			{
				var node:* = nodes.get(entity);
				if (node)
					nodes.config.optionalComponents.setComponent(node, entity, component);
			}
		}
		
		internal function componentRemovedFromEntity(entity:Entity, component:Class, bits:Vector.<uint>):void
		{
			var list:Vector.<Nodes>, nodes:Nodes, node:Object;
			
			list = _required.getNodesFor(component);
			for each (nodes in list)
			{
				node = nodes.get(entity);
				if (node)
					nodes.remove(entity);
			}
			
			list = _optional.getNodesFor(component);
			for each (nodes in list)
			{
				node = nodes.get(entity);
				if (node)
					nodes.config.optionalComponents.clearComponent(node, component);
			}
		}
		
	}
}
