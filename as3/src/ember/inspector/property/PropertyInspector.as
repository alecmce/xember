package ember.inspector.property
{
	import com.bit101.components.Label;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	
	public class PropertyInspector
	{
		private var _self:Sprite;
		private var _label:Label;
		private var _input:PropertyInput;
		
		private var _component:Object;
		private var _property:String;
		
		private var _isBound:Boolean;
		private var _isFocussed:Boolean;
		
		public function PropertyInspector()
		{
			_self = new Sprite();
			
			_label = new Label(_self, 0, 0, "");
			_label.width = 150;
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
		
		public function get input():PropertyInput
		{
			return _input;
		}
		
		public function set input(input:PropertyInput):void
		{
			if (_input == input)
				return;
			
			_input && removeInput(_input);
			_input = input;
			_input && addInput(_input);
			_isBound && _input && onBind();
		}
		
		public function bind(component:Object, property:String):void
		{
			_component = component;
			_property = property;
			
			_isBound = _component && _property && _component.hasOwnProperty(_property);
			if (_isBound && _input)
				onBind();
			else
				unbind();
		}
		
		public function unbind():void
		{
			_component = null;
			_property = null;
			
			if (_input)
			{
				_input.value = null;
				_input.enabled = false;
			}
			
			isFocussed = false;
		}

		public function update():void
		{
			if (!_isFocussed && _input)
				_input.value = _component[_property];
		}
		
		public function get isFocussed():Boolean
		{
			return _isFocussed;
		}

		public function set isFocussed(isFocussed:Boolean):void
		{
			if (!_isBound || _isFocussed == isFocussed)
				return;
			
			_isFocussed = isFocussed;
			if (_isFocussed)
				_input.focus = true;
			else
				_input.focus = false;
		}
		
		private function addInput(input:PropertyInput):void
		{
			_input = input;
			_input.self.x = 150;
			_self.addChild(_input.self);
			
			_input.changed.add(onInputChanged);
		}
		
		private function removeInput(input:PropertyInput):void
		{
			_self.removeChild(_input.self);
		
			_input.changed.remove(onInputChanged);
		}

		private function onInputChanged(value:*):void
		{
			_component[_property] = value;
		}
		
		private function onBind():void
		{
			_input.enabled = true;
			_input.value = _component[_property];
			_self.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void
		{
			isFocussed = true;
		}
		
	}
}
