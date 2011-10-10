package ember.io
{
	import flash.utils.describeType;
	
	final public class ComponentConfig
	{
		private var _type:String;
		private var _properties:Vector.<String>;
		private var _typeMap:Object;
		
		public function ComponentConfig(type:String, component:Object)
		{
			_type = type;
			_properties = new Vector.<String>();
			_typeMap = {};
			
			var description:XML = describeType(component);
			var encodeAll:Boolean = markedEncodeAll(description);
			
			var list:XMLList = description.variable;
			for each (var xml:XML in list)
			{
				var config:PropertyConfig = new PropertyConfig(encodeAll, xml);
				if (!config.encode)
					continue;
					
				var property:String = xml.@name;
				_properties.push(property);
				_typeMap[property] = xml.@type.toString();
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
		
		private function markedEncodeAll(xml:XML):Boolean
		{
			var ember:XML = xml.metadata.(@name == "Ember")[0];
			return ember && ember.arg.(@value == "encodeAll")[0];
		}
	}
}

import flash.utils.getDefinitionByName;

class PropertyConfig
{
	
	public var encode:Boolean;
	public var encoder:Class;
	
	public function PropertyConfig(encodeAll:Boolean, xml:XML)
	{
		var metadata:XML = xml.metadata.(@name == "Ember")[0];
		
		if (encodeAll)
			encode = !(metadata && metadata.arg.(@value == "ignore")[0]);
		else
			encode = metadata != null;
		
		if (encode && metadata)
		{
			metadata = metadata.arg.(@key == "encoder")[0];
			if (metadata)
				encoder = getDefinitionByName(metadata.@value) as Class;
		}
	}
	
}