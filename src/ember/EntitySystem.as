package ember
{
	import org.robotlegs.core.IInjector;
	
	public class EntitySystem
	{
		
		private var _entities:Entities;
		private var _sets:EntitySets;
		private var _systems:Systems;

		public function EntitySystem(injector:IInjector)
		{
			_entities = new Entities();
			_sets = new EntitySets(_entities);
			_systems = new Systems(_sets, injector);
		}
		
		public function createEntity(name:String = ""):Entity
		{
			return _entities.create(name);
		}
		
		public function getEntity(name:String):Entity
		{
			return _entities.get(name);
		}

		public function containsEntity(entity:Entity):Boolean
		{
			return _entities.contains(entity as ConcreteEntity);
		}

		public function removeEntity(entity:Entity):void
		{
			_entities.remove(entity as ConcreteEntity);
		}

		public function addSystem(systemClass:Class, nodeClass:Class = null):void
		{
			_systems.add(systemClass, nodeClass);
		}
		
	}
}
