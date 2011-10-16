package ember.inspector.property.inputs
{
	import com.bit101.components.PushButton;
	import ember.inspector.property.PropertyInput;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.osflash.signals.Signal;



	public class BooleanTypeInput implements PropertyInput
	{
		private var _self:Sprite;
		private var _button:PushButton;
		
		private var _changed:Signal;
		
		private var _enabled:Boolean;
		private var _focus:Boolean;

		public function BooleanTypeInput()
		{
			_self = new Sprite();
			_button = new PushButton(_self);
			_button.toggle = true;
			_button.enabled = false;
			
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
			_button.enabled = enabled;
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
				_button.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			else
				_button.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		public function get value():*
		{
			return _button.selected;
		}

		public function set value(value:*):void
		{
			if (!_enabled)
				return;
			
			_button.selected = value;
			_button.label = value ? "true" : "false";
		}

		public function get changed():Signal
		{
			return _changed;
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var code:uint = event.keyCode;
			if (code == Keyboard.SPACE)
			{
				var flag:Boolean = !value;
				value = flag;
				_changed.dispatch(flag);
			}
			else if (code == Keyboard.ENTER || code == Keyboard.TAB)
			{
				focus = false;
			}
		}
		
	}
}
