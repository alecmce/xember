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
			var list:XMLList = description.variable;
			
			var encodeSeparately:Boolean = !markedEncodeAll(description);
			for each (var xml:XML in list)
			{
				if (encodeSeparately ? !markedEncode(xml) : markedIgnore(xml))
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
		
		private function markedEncode(xml:XML):Boolean
		{
			var ember:XML = xml.metadata.(@name == "Ember")[0];
			return ember != null;
		}
		
		private function markedIgnore(xml:XML):Boolean
		{
			var ember:XML = xml.metadata.(@name == "Ember")[0];
			return ember && ember.arg.(@value == "ignore")[0];
		}
		
	}
}
