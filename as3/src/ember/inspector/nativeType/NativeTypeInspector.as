package ember.inspector.nativeType
{
	import mocks.MockStringComponent;

	import com.bit101.components.Label;

	import flash.display.Sprite;


	
	public class NativeTypeInspector extends Sprite
	{
		private var _label:Label;
		private var _input:NativeTypeInput;
		
		private var _component:MockStringComponent;
		private var _property:String;
		
		private var _isEnabled:Boolean;
		private var _isFocussed:Boolean;
		
		public function NativeTypeInspector()
		{
			_label = new Label(this, 0, 0, "");
			_label.width = 150;
		}
		
		public function get input():NativeTypeInput
		{
			return _input;
		}

		public function set input(input:NativeTypeInput):void
		{
			if (_input === input)
				return;
			
			_input && removeInput(_input);
			_input = input;
			_input && addInput(_input);
		}

		public function bind(component:MockStringComponent, property:String):void
		{
			_component = component;
			_property = property;
			
			if (_component && _property && _component.hasOwnProperty(_property))
				enable();
			else
				disable();
		}
		
		public function unbind():void
		{
			_component = null;
			_property = null;
			
			disable();
		}

		public function update():void
		{
			if (_isEnabled && !_isFocussed)
				onUpdate();
		}
		
		public function get isFocussed():Boolean
		{
			return _isFocussed;
		}

		public function set isFocussed(isFocussed:Boolean):void
		{
			if (!_isEnabled || _isFocussed == isFocussed)
				return;
			
			_isFocussed = isFocussed;
			if (_isFocussed)
				onGainFocus();
			else
				onLoseFocus();
		}
		
		protected function onUnbind():void
		{
			
		}
		
		protected function onUpdate():void
		{
			
		}
		
		protected function enable():void
		{
			
		}
		
		protected function disable():void
		{
			
		}
		
		protected function onGainFocus():void
		{
			
		}
		
		protected function onLoseFocus():void
		{

		}
		
		private function addInput(input:NativeTypeInput):void
		{
			_input = input;
			_input.self.x = 150;
			addChild(_input.self);
		}
		
		private function removeInput(input:NativeTypeInput):void
		{
			removeChild(_input.self);
		}
		
	}
}
