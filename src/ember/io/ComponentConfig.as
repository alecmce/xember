package ember.io
{
	import flash.utils.describeType;
	
	public class ComponentConfig
	{
		private var _type:String;
		private var _properties:Vector.<String>;
		private var _typeMap:Object;
		
		public function ComponentConfig(type:String, component:Object)
		{
			_type = type.replace("::", ".");
			_properties = new Vector.<String>();
			_typeMap = {};
			
			var description:XML = describeType(component);
			for each (var xml:XML in description.variable)
			{
				var ember:XML = xml.metadata.(@name == "Ember")[0];
				if (!ember)
					continue;
				
				var property:String = xml.@name;
				var type:String = xml.@type;
				
				_properties.push(property);
				_typeMap[property] = type.replace("::", ".");
			}
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get properties():Vector.<String>
		{
			return _properties;
		}

		public function getType(property:String):String
		{
			return _typeMap[property];
		}
		
	}
}
