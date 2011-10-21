package ember.inspector
{
	public class EntityInspector
	{
		private var _components:Object;
		
		public function EntityInspector()
		{
			_components = {};
		}
		
		public function addComponent(name:String, component:ComponentInspector):void
		{
			_components[name] = component;
		}

		public function getComponent(name:String):ComponentInspector
		{
			return _components[name];
		}
	}
}
