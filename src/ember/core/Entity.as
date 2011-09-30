package ember.core
{
	import org.osflash.signals.Signal;

	import flash.utils.Dictionary;
	
	final public class Entity
	{
		private var _name:String;
		
		private var _list:Vector.<Object>;
		private var _components:Dictionary;
		private var _componentAdded:Signal;
		private var _componentRemoved:Signal;
		
		public function Entity(name:String, componentAdded:Signal, componentRemoved:Signal)
		{
			_name = name;
			_list = new Vector.<Object>();
			_components = new Dictionary();
			_componentAdded = componentAdded;
			_componentRemoved = componentRemoved;
		}
		
		public function addComponent(component:Object, componentClass:Class = null):void
		{
			componentClass ||= component["constructor"];
			_components[componentClass] = component;
			_list.push(component);
			_componentAdded.dispatch(this, componentClass);
		}

		public function getComponents():Vector.<Object>
		{
			return _list;
		}

		public function getComponent(component:Class):Object
		{
			return _components[component];
		}

		public function removeComponent(component:Class):void
		{
			if (_components[component] == null)
				return;
			
			delete _components[component];
			_list.splice(_list.indexOf(component), 1);
			_componentRemoved.dispatch(this, component);
		}

		public function hasComponent(component:Class):Boolean
		{
			return _components[component] != null;
		}

		public function get name():String
		{
			return _name;
		}

	}
}
