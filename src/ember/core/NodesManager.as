package ember.core
{
	import flash.utils.Dictionary;

	final internal class NodesManager
	{
		private var _entities:Entities;
		private var _nodesMap:Dictionary;
		private var _factory:NodesFactory;
		
		private var _required:NodesComponentMap;
		private var _optional:NodesComponentMap;
		
		public function NodesManager(entities:Entities)
		{
			_entities = entities;
			_entities.entityComponentAdded.add(onEntityComponentAdded);
			_entities.entityComponentRemoved.add(onEntityComponentRemoved);
			
			_required = new NodesComponentMap();
			_optional = new NodesComponentMap();
			
			_nodesMap = new Dictionary();
			_factory = new NodesFactory();
		}

		public function get(nodeClass:Class):Nodes
		{
			var nodes:Nodes = _nodesMap[nodeClass] ||= _factory.generateSet(nodeClass, _entities.list);

			var config:NodesConfig = nodes.config;
			_required.add(config.requiredComponents, nodes);
			_optional.add(config.optionalComponents, nodes);
			
			return nodes;
		}
		
		private function onEntityComponentAdded(entity:Entity, component:Class):void
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
		
		private function onEntityComponentRemoved(entity:Entity, component:Class):void
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

		public function clear():void
		{
			for each (var nodes:Nodes in _nodesMap)
				nodes.clear();
		}
		
	}
}
