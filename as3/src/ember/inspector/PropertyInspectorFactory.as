package ember.inspector
{
	import ember.inspector.properties.BooleanInspector;
	import ember.inspector.properties.IntInspector;
	import ember.inspector.properties.NumberInspector;
	import ember.inspector.properties.StringInspector;
	import ember.inspector.properties.UintInspector;

	import flash.utils.Dictionary;

	
	public class PropertyInspectorFactory
	{
		private var _typeMap:Dictionary;
		
		public function PropertyInspectorFactory()
		{
			_typeMap = new Dictionary();
			
			bind(String, StringInspector);
			bind(Boolean, BooleanInspector);
			bind(int, IntInspector);
			bind(uint, UintInspector);
			bind(Number, NumberInspector);
		}

		public function bind(type:Class, inspector:Class):void
		{
			if (_typeMap[type])
				throw new Error("Unable to bind to type " + type + " - binding already found");
			
			_typeMap[type] = inspector;
		}
		
		public function unbind(type:Class):void
		{
			delete _typeMap[type];
		}
		
		public function getInspector(type:Class):PropertyInspector
		{
			var inspector:Class = _typeMap[type];
			if (!inspector)
				return null;
			
			return new inspector();
		}
	}
}
