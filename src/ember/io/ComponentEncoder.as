package ember.io
{
	import flash.utils.getDefinitionByName;
	
	final public class ComponentEncoder
	{
		private var _configFactory:ComponentConfigFactory;
		
		public function ComponentEncoder(configFactory:ComponentConfigFactory)
		{
			_configFactory = configFactory;
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
		
		public function decode(object:Object):Object
		{
			for (var type:String in object)
			{
				var componentClass:Class = getDefinitionByName(type) as Class;
				var component:* = new componentClass();
				
				var values:Object = object[type];
				for (var property:String in values)
					component[property] = values[property];
			}
			
			return component;
		}
	}
}
