package ember.inspector.properties
{
	import ember.inspector.PropertyInspector;

	import com.bit101.components.InputText;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class StringInspector implements PropertyInspector
	{
		private var _self:Sprite;
		protected var _input:InputText;
		
		private var _bound:Boolean;
		private var _component:Object;
		private var _property:String;

		private var _editing:Boolean;

		public function StringInspector()
		{
			_self = new Sprite();
			_input = new InputText(_self);
			_input.enabled = false;
		}

		public function get self():DisplayObject
		{
			return _self;
		}
		
		public function bind(component:Object, property:String):void
		{
			_bound = component && property && component.hasOwnProperty(property);
			
			if (_bound)
				onBind(component, property);
			else
				onUnbind();
		}

		public function unbind():void
		{
			onUnbind();
		}
		
		public function update():void
		{
			if (!_bound || _editing)
				return;
			
			_input.text = _component[_property];
			_input.draw();
		}

		private function onBind(component:Object, property:String):void
		{
			_component = component;
			_property = property;
			update();
			
			_input.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_input.enabled = true;
		}
		
		private function onUnbind():void
		{
			_component = null;
			_property = null;
			
			_input.enabled = false;
			_input.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var code:uint = event.keyCode;
			switch (code)
			{
				case Keyboard.ENTER:
					_editing = false;
					_component[_property] = _input.text;
					break;
				case Keyboard.TAB:
					break;
				default:
					_editing = true;
			}
		}
		
	}
}
