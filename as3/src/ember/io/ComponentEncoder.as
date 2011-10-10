package ember.io
{
	import ember.io.encoders.PointEncoder;
	import ember.io.encoders.RectangleEncoder;

	import flash.utils.getDefinitionByName;
	
	final public class ComponentEncoder
	{
		private var _configFactory:ComponentConfigFactory;
		private var _customEncoders:CustomEncoders;
		
		public function ComponentEncoder(configFactory:ComponentConfigFactory)
		{
			_configFactory = configFactory;
			
			_customEncoders = new CustomEncoders();
			_customEncoders.addEncoder(PointEncoder);
			_customEncoders.addEncoder(RectangleEncoder);
		}
		
		public function addCustomEncoder(encoder:Class):void
		{
			_customEncoders.addEncoder(encoder);
		}
		
		public function removeCustomEncoder(encoder:Class):void
		{
			_customEncoders.removeEncoder(encoder);
		}
		
		public function encode(component:Object):Object
		{
			var config:ComponentConfig = _configFactory.get(component);
			
			var list:Object = {};
			
			var properties:Vector.<String> = config.properties;
			for each (var property:String in properties)
			{
				var type:String = config.getType(property);
				var value:Object = component[property];
				if (isNativeType(type))
				{
					list[property] = value;
				}
				else
				{
					var encoder:Object = _customEncoders.getEncoderForType(type);
					if (encoder)
						list[property] = {type:type, value:encoder.encode(value)};
				}
			}

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
				{
					var value:Object = values[property];
					if (isNative(value))
					{
						component[property] = value;
					}
					else
					{
						var encoder:Object = _customEncoders.getEncoderForType(value.type);
						if (encoder)
							component[property] = encoder.decode(value.value);
					}
				}
			}
			
			return component;
		}
		
		private function isNativeType(type:String):Boolean
		{
			return type == "int" || type == "uint" || type == "Number" || type == "String" || type == "Boolean";
		}
		
		private function isNative(object:*):Boolean
		{
			return object is Number || object is int || object is uint || object is String || object is Boolean;
		}

	}
}
