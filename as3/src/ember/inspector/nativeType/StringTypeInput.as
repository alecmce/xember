package ember.inspector.nativeType
{
	import com.bit101.components.InputText;
	import org.osflash.signals.Signal;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class StringTypeInput implements NativeTypeInput
	{
		private var _self:Sprite;
		protected var _input:InputText;
		
		private var _changed:Signal;
		
		private var _enabled:Boolean;
		private var _focus:Boolean;

		public function StringTypeInput()
		{
			_self = new Sprite();
			_input = new InputText(_self);
			_input.enabled = false;
			
			_changed = new Signal();
		}

		public function get self():DisplayObject
		{
			return _self;
		}

		public function get enabled():Boolean
		{
			return _enabled;
		}

		public function set enabled(enabled:Boolean):void
		{
			if (_enabled == enabled)
				return;
			
			_enabled = enabled;
			_input.enabled = enabled;
			if (!_enabled)
				_focus = false;
		}

		public function get focus():Boolean
		{
			return _focus;
		}

		public function set focus(focus:Boolean):void
		{
			if (!_enabled)
				return;
			
			_focus = focus;
			if (_focus)
				_input.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			else
				_input.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		public function get value():*
		{
			return _input.text;
		}

		public function set value(value:*):void
		{
			if (!_enabled)
				return;
			
			_input.text = value;
			_input.draw();
		}

		public function get changed():Signal
		{
			return _changed;
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var code:uint = event.keyCode;
			if (code == Keyboard.ENTER || code == Keyboard.TAB)
			{
				focus = false;
				_changed.dispatch(_input.text);
			}
		}
		
	}
}
