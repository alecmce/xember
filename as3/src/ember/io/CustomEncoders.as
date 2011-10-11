package ember.io
{
	import flash.utils.Dictionary;
	
	final internal class CustomEncoders
	{
		
		private var _encoderMap:Dictionary;
		private var _typeMap:Dictionary;

		public function CustomEncoders()
		{
			_encoderMap = new Dictionary();
			_typeMap = new Dictionary();
		}

		public function addEncoder(encoder:Class):Boolean
		{
			var description:EncoderDescription = new EncoderDescription(encoder);
			if (description.isError)
				throw new Error(description.errorDescription);

			var type:String = description.type;
			if (_typeMap[type] != null)
				throw new Error("Custom encoder collision - you cannot define two custom encoders for " + type);
			
			var instance:Object = new encoder();
			
			_encoderMap[encoder] = new EncoderReference(type, instance);
			_typeMap[type] = instance;
			
			return !description.isError;
		}

		public function removeEncoder(encoder:Class):Boolean
		{
			var reference:EncoderReference = _encoderMap[encoder];
			if (!reference)
				return false;
			
			delete _encoderMap[encoder];
			delete _typeMap[reference.type];
			return true;
		}

		public function getEncoderForType(type:String):Object
		{
			return _typeMap[type];
		}

	}
}

import flash.utils.describeType;

class EncoderReference
{
	public var type:String;
	public var instance:Object;
	
	public function EncoderReference(type:String, instance:Object)
	{
		this.type = type;
		this.instance = instance;
	}

}

class EncoderDescription
{
	
	public var isError:Boolean;
	public var errorDescription:String;
	public var type:String;
	
	public function EncoderDescription(klass:Class)
	{
		var description:XML = describeType(klass);
		
		var encoder:XML = description..method.(@name == "encode")[0];
		if (!encoder || encoder.parameter.length() != 1 || encoder.@returnType != "Object")
		{
			errorDescription = "Unable to create encoder from class - an encoder needs a public function encode(Type):Object";
			isError = true;
			return;
		}
		
		var decoder:XML = description..method.(@name == "decode")[0];
		if (!decoder || decoder.parameter.length() != 1 || decoder.parameter.@type != "Object")
		{
			errorDescription = "Unable to create encoder from class - an encoder needs a public function decode(Object):Type";
			isError = true;
			return;
		}
		
		type = encoder.parameter.@type;
		if (decoder.@returnType != type)
		{
			errorDescription = "Unable to create encoder from class - the encoder's type doesn't match the decoder's return type";
			isError = true;
			return;
		}
	}
	
}