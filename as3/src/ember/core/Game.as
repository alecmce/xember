package ember.core
{
	import ember.core.ds.BitfieldMap;

	import org.robotlegs.core.IInjector;
	
	final public class Game
	{
		private var _entities:Entities;
		private var _nodes:NodesManager;
		private var _systems:Systems;

		public function Game(injector:IInjector)
		{
			var list:Vector.<Entity> = new Vector.<Entity>();
			var bitfieldMap:BitfieldMap = new BitfieldMap();
			var factory:NodesFactory = new NodesFactory(list);
			var nodesManager:NodesManager = new NodesManager(factory);
			
			_entities = new Entities(list, bitfieldMap, nodesManager);
			_nodes = new NodesManager(factory);
			_systems = new Systems(injector);
			
			injector.mapValue(Game, this);
		}
		
		public function createEntity(name:String = ""):Entity
		{
			return _entities.create(name);
		}
		
		public function getEntity(name:String):Entity
		{
			return _entities.get(name);
		}

		public function getEntities():Vector.<Entity>
		{
			return _entities.getAll();
		}

		public function containsEntity(entity:Entity):Boolean
		{
			return _entities.contains(entity);
		}

		public function removeEntity(entity:Entity):void
		{
			_nodes.removeEntity(entity);
			_entities.remove(entity);
		}

		public function removeAllEntities():void
		{
			_entities.removeAll();
			_nodes.clear();
		}
		
		public function getNodes(nodeClass:Class):Nodes
		{
			return _nodes.get(nodeClass);
		}

		public function addSystem(systemClass:Class):Object
		{
			return _systems.add(systemClass);
		}

		public function hasSystem(system:Class):Boolean
		{
			return _systems.has(system);
		}

		public function getSystem(system:Class):Object
		{
			return _systems.get(system);
		}

		public function removeSystem(system:Class):Boolean
		{
			return _systems.remove(system);
		}
		

	}
}
