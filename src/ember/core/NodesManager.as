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
			_required.add(nodes, config.requiredComponents);
			_optional.add(nodes, config.optionalComponents);
			
			return nodes;
		}
		
		private function onEntityComponentAdded(entity:Entity, component:Class):void
		{
			for each (var nodes:Nodes in _nodesMap)
			{
				if (nodes.config.requiredComponents.areComponentsIn(entity))
					nodes.add(entity);
			}
		}
		
		private function onEntityComponentRemoved(entity:Entity, component:Class):void
		{
			for each (var nodes:Nodes in _nodesMap)
			{
				if (nodes.config.requiredComponents.contains(component))
					nodes.remove(entity);
			}
		}

		public function clear():void
		{
			for each (var nodes:Nodes in _nodesMap)
				nodes.clear();
		}
		
	}
}
