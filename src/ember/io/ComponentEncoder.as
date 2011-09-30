package ember.io
{
	
	public class ComponentEncoder
	{
		private var _configFactory:ComponentConfigFactory;
		
		public function ComponentEncoder()
		{
			_configFactory = new ComponentConfigFactory();
		}
		
		public function encode(component:Object):Object
		{
			var config:ComponentConfig = _configFactory.get(component);
			
			var list:Object = {};
			
			var properties:Vector.<String> = config.properties;
			for each (var property:String in properties)
				list[property] = component[property];

			var output:Object = {};
			output[config.type] = list;
			
			return output;
		}
	}
}
