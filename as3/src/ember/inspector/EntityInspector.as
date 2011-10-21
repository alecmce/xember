package ember.inspector
{
	import flash.utils.Dictionary;
	
	public class EntityInspector
	{
		private var _components:Dictionary;
		
		public function EntityInspector()
		{
			_components = new Dictionary();
		}
		
		public function addComponent(component:Class, inspector:ComponentInspector):void
		{
			_components[component] = inspector;
		}

		public function removeComponent(component:Class):void
		{
			delete _components[component];
		}
		
		public function getComponent(component:Class):ComponentInspector
		{
			return _components[component];
		}

		public function dispose():void
		{
			// TODO
		}

	}
}
