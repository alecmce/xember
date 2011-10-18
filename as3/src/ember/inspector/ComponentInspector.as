package ember.inspector
{
	import com.bit101.components.Label;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ComponentInspector
	{
		private var _self:Sprite;
		private var _title:Label;
		private var _inner:Sprite;
		
		private var _wrapperMap:Object;
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
			
			_wrapperMap = {};
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
			_propertyMap[label] = inspector;

			var wrapper:PropertyWrapper = new PropertyWrapper();
			_wrapperMap[label] = wrapper;
			wrapper.label = label;
			wrapper.inspector = inspector;
			
			wrapper.self.y = _height;
			_inner.addChild(wrapper.self);
			_height += wrapper.self.height;
		}
		
		public function getProperty(label:String):PropertyInspector
		{
			return _propertyMap[label];
		}
		
		public function clearProperties():void
		{
			var count:int = _inner.numChildren;
			while (count--)
				_inner.removeChildAt(0);
			
			_wrapperMap = {};
			_propertyMap = {};
		}

		public function update():void
		{
			var inspector:PropertyInspector;
			
			for each (inspector in _propertyMap)
				inspector.update();
		}
		
	}
}
