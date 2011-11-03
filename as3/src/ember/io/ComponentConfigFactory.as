package ember.io
{
	import flash.utils.getQualifiedClassName;

	import flash.utils.Dictionary;
	
	final internal class ComponentConfigFactory
	{
		private var _map:Dictionary;
		
		public function ComponentConfigFactory()
		{
			_map = new Dictionary();
		}
		
		public function get(component:Object):ComponentConfig
		{
			var type:String = getQualifiedClassName(component);
			
			return _map[type] ||= new ComponentConfig(type, component);
		}
	}
}
