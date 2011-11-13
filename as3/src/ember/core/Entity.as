package ember.core
{
	import ember.core.ds.BitfieldMap;

	import flash.utils.Dictionary;
	
	final public class Entity
	{
		private var _name:String;
		private var _nodesManager:NodesManager;
		private var _bitfieldMap:BitfieldMap;
		
		private var _components:Dictionary;
		private var _bits:Vector.<uint>;
		
		internal var nodes:Dictionary;
				 
		public function Entity(name:String, nodesManager:NodesManager, bitfieldMap:BitfieldMap)
		{
			_name = name;
			_nodesManager = nodesManager;
			_bitfieldMap = bitfieldMap;
			
			_components = new Dictionary();
			_bits = new Vector.<uint>();
			
			nodes = new Dictionary();
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function addComponent(component:Object):void
		{
			var klass:Class = component["constructor"];
			
			if (_components[klass] != null)
				throw "Error: Cannot add multiple components of the same type to an entity";
			
			_components[klass] = component;
			_bitfieldMap.map(klass, _bits);
			_nodesManager.componentAddedToEntity(this, klass, _bits);
		}

		public function getComponent(klass:Class):Object
		{
			return _components[klass];
		}

		public function removeComponent(klass:Class):void
		{
			if (_components[klass] == null)
				return;
			
			_bitfieldMap.unmap(klass, _bits);
			delete _components[klass];
			_nodesManager.componentRemovedFromEntity(this, klass, _bits);
		}

		public function hasComponent(component:Class):Boolean
		{
			return _components[component] != null;
		}
		
		public function getComponents():Vector.<Object>
		{
			var list:Vector.<Object> = new Vector.<Object>();
			
			for each (var component:Object in _components)
				list.push(component);
				
			return list;
		}

	}
}
