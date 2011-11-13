package ember.core
{
	import ember.core.ds.BitfieldMap;

	import flash.utils.Dictionary;
	
	final internal class Entities
	{
		private var _list:Vector.<Entity>;
		private var _count:uint;
		private var _nodesManager:NodesManager;
		private var _bitfieldMap:BitfieldMap;
		
		private var _nameMap:Dictionary;
		
		public function Entities(entities:Vector.<Entity>, bitfieldMap:BitfieldMap, nodesManager:NodesManager)
		{
			_list = entities;
			_count = entities.length;
			_bitfieldMap = bitfieldMap;
			_nodesManager = nodesManager;
			
			_nameMap = new Dictionary();
		}

		public function create(name:String = ""):Entity
		{
			var entity:Entity = new Entity(name, _nodesManager, _bitfieldMap);
			_count = _list.push(entity);
			
			if (name != "")
			{
				var existing:Entity = _nameMap[name];
				if (existing != null)
					throw new Error("You cannot call two entities the same name");
				
				_nameMap[name] = entity;
				_nameMap[entity] = name;
			}
			
			return entity;
		}
		
		public function get(name:String):Entity
		{
			return _nameMap[name];
		}

		public function getAll():Vector.<Entity>
		{
			return _list.concat();
		}

		public function contains(entity:Entity):Boolean
		{
			return _list.indexOf(entity) != -1;
		}
		
		public function remove(entity:Entity):void
		{
			var i:int = _list.indexOf(entity);
			if (i == -1)
				return;

			var name:String = _nameMap[entity];
			if (name != null)
			{
				delete _nameMap[entity];
				delete _nameMap[name];
			}
			
			_list.splice(i, 1);
		}
		
		public function removeAll():void
		{
			_list.length = 0;
		}

		public function get list():Vector.<Entity>
		{
			return _list;
		}
		
	}
}
