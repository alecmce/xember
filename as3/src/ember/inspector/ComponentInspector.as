package ember.inspector
{
	import ember.inspector.property.PropertyInspector;

	import com.bit101.components.Label;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ComponentInspector
	{
		private var _self:Sprite;
		private var _title:Label;
		private var _inner:Sprite;
		
		private var _isFocussed:Boolean;
		private var _focusIndex:int = -1;
		
		private var _properties:Vector.<PropertyInspector>;
		private var _propertyMap:Object;
		private var _height:uint;
		
		public function ComponentInspector()
		{
			_self = new Sprite();
			_title = new Label(_self);
			_title.width = 300;
			
			_inner = new Sprite();
			_inner.y = _title.height;
			_self.addChild(_inner);
			
			_properties = new Vector.<PropertyInspector>();
			_propertyMap = {};
			_height = 0;
		}
		
		public function get self():DisplayObject
		{
			return _self;
		}

		public function get title():String
		{
			return _title.text;
		}
		
		public function set title(title:String):void
		{
			_title.text = title;
		}
		
		public function addProperty(label:String, inspector:PropertyInspector):void
		{
			_properties.push(inspector);
			_propertyMap[label] = inspector;
			
			inspector.self.y = _height;
			_inner.addChild(inspector.self);
			_height += inspector.self.height;
		}
		
		public function getProperty(label:String):PropertyInspector
		{
			return _propertyMap[label];
		}
		
		public function clearProperties():void
		{
			var count:int = _properties.length;
			for (var i:int = 0; i < count; i++)
				_inner.removeChild(_properties[i].self);
			
			_properties.length = 0;
			_height = 0;
		}

		public function get isFocussed():Boolean
		{
			return _isFocussed;
		}

		public function set isFocussed(isFocussed:Boolean):void
		{
			if (_isFocussed == isFocussed)
				return;
			
			_isFocussed = isFocussed;
			if (_isFocussed)
				focusNextProperty();
			else
				_focusIndex = -1;
		}

		private function focusNextProperty():void
		{
			_focusIndex >= 0 && (_properties[_focusIndex].isFocussed = false);
			_properties[++_focusIndex].isFocussed = true;
		}
		
	}
}
