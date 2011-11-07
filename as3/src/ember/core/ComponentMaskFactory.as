package ember.core
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	final internal class ComponentMaskFactory
	{
		private var _map:Dictionary;
		
		private var _objectMask:ObjectMask;
		
		public function ComponentMaskFactory(objectMask:ObjectMask)
		{
			_objectMask = objectMask;
			
			_map = new Dictionary();
		}
		
		public function getMask(klass:Class):Vector.<uint>
		{
			var mask:Vector.<uint> = _map[klass];
			if (mask)
				return mask;
			
			var xml:XML = describeType(klass);
			var list:XMLList = xml.factory.extendsClass.(@type != "Object");
			
			mask = _objectMask.map(klass);
			for each (xml in list)
				_objectMask.map(getDefinitionByName(xml.@type), mask);
			
			_map[klass] = mask;
			return mask;
		}
		
		
	}
	
}
