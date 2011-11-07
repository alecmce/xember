package ember.core
{
	import org.osflash.signals.Signal;

	import flash.utils.Dictionary;
	
	final public class Entity
	{
		private var _name:String;
		
		private var _listOfComponents:Vector.<Object>;
		private var _listOfClasses:Vector.<Class>;
		private var _components:Dictionary;
		private var _componentAdded:Signal;
		private var _componentRemoved:Signal;
		
		public function Entity(name:String, componentAdded:Signal, componentRemoved:Signal)
		{
			_name = name;
			_listOfComponents = new Vector.<Object>();
			_listOfClasses = new Vector.<Class>();
			_components = new Dictionary();
			_componentAdded = componentAdded;
			_componentRemoved = componentRemoved;
		}
		
		public function addComponent(component:Object):void
		{
			var klass:Class = component["constructor"];
			
			_components[klass] = component;
			_listOfComponents.push(component);
			_listOfClasses.push(klass);
			_componentAdded.dispatch(this, klass);
		}

		public function getComponents():Vector.<Object>
		{
			return _listOfComponents;
		}
		
		public function getClasses():Vector.<Class>
		{
			return _listOfClasses;
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
			_listOfComponents.splice(_listOfComponents.indexOf(component), 1);
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
