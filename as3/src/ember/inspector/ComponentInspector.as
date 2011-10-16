package ember.inspector
{
	import ember.io.ComponentConfig;

	import com.bit101.components.Label;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ComponentInspector
	{
		private var _self:Sprite;
		private var _title:Label;
		private var _inner:Sprite;
		
		private var _config:ComponentConfig;
		
		public function ComponentInspector()
		{
			_self = new Sprite();
			_title = new Label(_self);
			_title.width = 300;
			
			_inner = new Sprite();
			_inner.y = _title.height;
			_self.addChild(_inner);
		}
		
		public function setComponent(component:Object, config:ComponentConfig):void
		{
			_config = config;
			
			_title.text = config.type;
			
			
		}
		
		public function get self():DisplayObject
		{
			return _self;
		}

		public function get title():String
		{
			return _title.text;
		}
		
	}
}
