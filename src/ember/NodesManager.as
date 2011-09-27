package ember
{
	import flash.utils.Dictionary;

	final internal class NodesManager
	{
		private var _entities:Entities;
		private var _setMap:Dictionary;
		private var _factory:NodesFactory;
		
		public function NodesManager(entities:Entities)
		{
			_entities = entities;
			_entities.entityComponentAdded.add(onEntityComponentAdded);
			_entities.entityComponentRemoved.add(onEntityComponentRemoved);
			
			_setMap = new Dictionary();
			_factory = new NodesFactory();
		}

		public function get(nodeClass:Class):Nodes
		{
			return _setMap[nodeClass] ||= _factory.generateSet(nodeClass, _entities.list);
		}
		
		private function onEntityComponentAdded(entity:ConcreteEntity, component:Class):void
		{
			for each (var entitySet:Nodes in _setMap)
			{
				if (entitySet.config.matchesConfiguration(entity))
					entitySet.add(entity);
			}
		}
		
		private function onEntityComponentRemoved(entity:ConcreteEntity, component:Class):void
		{
			for each (var entitySet:Nodes in _setMap)
			{
				if (entitySet.config.contains(component))
					entitySet.remove(entity);
			}
		}
		
	}
}
