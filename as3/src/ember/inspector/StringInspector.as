package ember.inspector
{
	import mocks.MockStringComponent;

	import com.bit101.components.InputText;
	import com.bit101.components.Label;

	import org.osflash.signals.Signal;

	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class StringInspector extends Sprite
	{
		public var label:Label;
		public var input:InputText;
		
		private var _update:Signal;
		
		private var _component:MockStringComponent;
		private var _property:String;
		
		private var _isEnabled:Boolean;
		private var _isFocussed:Boolean;

		public function StringInspector(update:Signal)
		{
			_update = update;
			
			label = new Label(this, 0, 0, "");
			label.width = 150;
			
			input = new InputText(this, 150, 0, "");
			input.width = 150;
			input.enabled = false;
		}
		
		public function bind(component:MockStringComponent, property:String):void
		{
			_component = component;
			_property = property;
			
			setEnabled(_component && _property && _component[_property] != null);
		}
		
		public function unbind():void
		{
			_update.remove(onUpdate);
			
			_component = null;
			_property = null;
			
			input.text = "";
			input.enabled = false;
		}

		public function get value():String
		{
			return input.text;
		}
		
		public function set value(value:String):void
		{
			_component[_property] = value;
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
			parent && (parent.stage.focus = input);
			input.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		private function setEnabled(isEnabled:Boolean):void
		{
			if (_isEnabled == isEnabled)
				return;
			
			_isEnabled = isEnabled;
			
			if (_isEnabled)
			{
				addEventListener(MouseEvent.CLICK, onClick);
				_update.add(onUpdate);
				
				var value:String = _component[_property];
				input.text = value;
				input.textField.setSelection(0, value.length);
			}
			else
			{
				removeEventListener(MouseEvent.CLICK, onClick);
				_update.remove(onUpdate);
				
				input.text = "";
			}
			
			input.enabled = isEnabled;
		}
		
		private function onClick(event:MouseEvent):void
		{
			isFocussed = true;
		}
		
		private function onUpdate():void
		{
			if (!_isFocussed)
				input.text = _component[_property];
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var code:uint = event.keyCode;
			if (code == Keyboard.ENTER || code == Keyboard.TAB)
			{
				_component[_property] = input.text;
				isFocussed = false;
			}
		}
		
	}
}
