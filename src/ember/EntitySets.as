package ember
{
	import flash.utils.Dictionary;

	final internal class EntitySets
	{
		private var _entities:Entities;
		private var _setMap:Dictionary;
		private var _factory:EntitySetFactory;
		
		public function EntitySets(entities:Entities)
		{
			_entities = entities;
			_entities.entityComponentAdded.add(onEntityComponentAdded);
			_entities.entityComponentRemoved.add(onEntityComponentRemoved);
			
			_setMap = new Dictionary();
			_factory = new EntitySetFactory();
		}

		public function get(nodeClass:Class):ConcreteEntitySet
		{
			return _setMap[nodeClass] ||= _factory.generateSet(nodeClass, _entities.list);
		}
		
		private function onEntityComponentAdded(entity:ConcreteEntity, component:Class):void
		{
			for each (var entitySet:ConcreteEntitySet in _setMap)
			{
				if (entitySet.configuration.matchesConfiguration(entity))
					entitySet.add(entity);
			}
		}
		
		private function onEntityComponentRemoved(entity:ConcreteEntity, component:Class):void
		{
			for each (var entitySet:ConcreteEntitySet in _setMap)
			{
				if (entitySet.configuration.contains(component))
					entitySet.remove(entity);
			}
		}
		
	}
}
