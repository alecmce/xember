package ember.inspector
{
	import com.bit101.components.Label;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	final internal class PropertyWrapper
	{
		private var _self:Sprite;
		private var _label:Label;
		private var _inspector:PropertyInspector;
		
		public function PropertyWrapper()
		{
			_self = new Sprite();
			
			_label = new Label(_self, 0, 0, "");
			_label.width = 100;
		}
		
		public function get self():DisplayObject
		{
			return _self;
		}
		
		public function get label():String
		{
			return _label.text;
		}

		public function set label(label:String):void
		{
			_label.text = label;
		}
		
		public function get inspector():PropertyInspector
		{
			return _inspector;
		}
		
		public function set inspector(inspector:PropertyInspector):void
		{
			if (_inspector == inspector)
				return;
			
			_inspector && removeInput(_inspector);
			_inspector = inspector;
			_inspector && addInput(_inspector);
		}
		
		private function addInput(inspector:PropertyInspector):void
		{
			_inspector = inspector;
			_inspector.self.x = 100;
			_self.addChild(_inspector.self);
		}
		
		private function removeInput(inspector:PropertyInspector):void
		{
			_self.removeChild(_inspector.self);
		}
		
	}
}
