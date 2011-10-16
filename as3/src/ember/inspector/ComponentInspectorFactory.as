package ember.inspector
{
	import ember.inspector.property.PropertyInspector;
	import ember.inspector.property.PropertyInspectorFactory;
	import ember.io.ComponentConfig;
	import ember.io.ComponentConfigFactory;
	
	public class ComponentInspectorFactory
	{
		
		private var _configs:ComponentConfigFactory;
		private var _properties:PropertyInspectorFactory;

		public function ComponentInspectorFactory(configs:ComponentConfigFactory)
		{
			_configs = configs;
			_properties = new PropertyInspectorFactory();
		}
		
		public function getInspector(component:Object):ComponentInspector
		{
			var inspector:ComponentInspector = new ComponentInspector();

			var config:ComponentConfig = _configs.get(component);
			var keys:Vector.<String> = config.properties;
			
			var count:uint = keys.length;
			for (var i:int = 0; i < count; i++)
			{
				var key:String = keys[i];
				var klass:Class = config.getType(key);
				
				var prop:PropertyInspector = _properties.getInspector(key, klass);
				prop.bind(component, key);
				
				inspector.addProperty(key, prop);
			}
			
			return inspector;
		}
		
	}
}
