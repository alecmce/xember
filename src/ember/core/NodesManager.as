package ember.core
{
	import flash.utils.Dictionary;

	final internal class NodesManager
	{
		private var _entities:Entities;
		private var _nodesMap:Dictionary;
		private var _factory:NodesFactory;
		
		public function NodesManager(entities:Entities)
		{
			_entities = entities;
			_entities.entityComponentAdded.add(onEntityComponentAdded);
			_entities.entityComponentRemoved.add(onEntityComponentRemoved);
			
			_nodesMap = new Dictionary();
			_factory = new NodesFactory();
		}

		public function get(nodeClass:Class):Nodes
		{
			return _nodesMap[nodeClass] ||= _factory.generateSet(nodeClass, _entities.list);
		}
		
		private function onEntityComponentAdded(entity:Entity, component:Class):void
		{
			for each (var nodes:Nodes in _nodesMap)
			{
				if (nodes.config.matchesConfiguration(entity))
					nodes.add(entity);
			}
		}
		
		private function onEntityComponentRemoved(entity:Entity, component:Class):void
		{
			for each (var nodes:Nodes in _nodesMap)
			{
				if (nodes.config.contains(component))
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
