package ember
{
	import org.osflash.signals.Signal;

	import flash.utils.Dictionary;
	
	final internal class Entities
	{
		private var _list:Vector.<ConcreteEntity>;
		private var _nameMap:Dictionary;
		private var _count:uint;
		
		private var _entityAttributeAdded:Signal;
		private var _entityAttributeRemoved:Signal;
		
		public function Entities()
		{
			_list = new Vector.<ConcreteEntity>();
			_nameMap = new Dictionary();
			_count = 0;
			
			_entityAttributeAdded = new Signal(ConcreteEntity, Class);
			_entityAttributeRemoved = new Signal(ConcreteEntity, Class);
		}

		public function create(name:String = ""):ConcreteEntity
		{
			var entity:ConcreteEntity = new ConcreteEntity(_entityAttributeAdded, _entityAttributeRemoved);
			_count = _list.push(entity);
			
			if (name != "")
			{
				var existing:ConcreteEntity = _nameMap[name];
				if (existing != null)
					throw new Error("You cannot call two entities the same name");
				
				_nameMap[name] = entity;
				_nameMap[entity] = name;
			}
			
			return entity;
		}
		
		public function get(name:String):ConcreteEntity
		{
			return _nameMap[name];
		}

		public function contains(entity:ConcreteEntity):Boolean
		{
			return _list.indexOf(entity) != -1;
		}
		
		public function remove(entity:ConcreteEntity):void
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

		public function get list():Vector.<ConcreteEntity>
		{
			return _list;
		}
		
		public function get entityAttributeAdded():Signal
		{
			return _entityAttributeAdded;
		}
		
		public function get entityAttributeRemoved():Signal
		{
			return _entityAttributeRemoved;
		}
		
	}
}
