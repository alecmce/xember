package ember
{
	import org.osflash.signals.Signal;

	import flash.utils.Dictionary;
	
	final internal class ConcreteEntity implements Entity
	{
		private var _components:Dictionary;
		private var _componentAdded:Signal;
		private var _componentRemoved:Signal;
		
		public function ConcreteEntity(componentAdded:Signal, componentRemoved:Signal)
		{
			_components = new Dictionary();
			_componentAdded = componentAdded;
			_componentRemoved = componentRemoved;
		}
		
		public function addComponent(component:Object, componentClass:Class = null):void
		{
			componentClass ||= component["constructor"];
			_components[componentClass] = component;
			_componentAdded.dispatch(this, componentClass);
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
			_componentRemoved.dispatch(this, component);
		}

		public function hasComponent(component:Class):Boolean
		{
			return _components[component] != null;
		}

	}
}
