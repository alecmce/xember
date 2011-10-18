package ember.inspector.properties
{
	import ember.inspector.PropertyInspector;

	import com.bit101.components.InputText;
	import com.bit101.components.Label;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	public class PointInspector implements PropertyInspector
	{
		private var _self:Sprite;
		
		private var _x:InputText;
		private var _y:InputText;
		
		private var _bound:Boolean;
		private var _editing:Boolean;
		
		private var _pt:Point;
		
		public function PointInspector()
		{
			_self = new Sprite();
			
			new Label(_self, 0).text = "(";
			new Label(_self, 75).text = ",";
			new Label(_self, 145).text = ")";
			
			_x = new InputText(_self, 10);
			_x.width = 65;
			_x.enabled = false;
			
			_y = new InputText(_self, 80);
			_y.width = 65;
			_y.enabled = false;
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
			
			_x.text = _pt.x.toString();
			_x.draw();
			
			_y.text = _pt.y.toString();
			_y.draw();
		}

		private function onBind(component:Object, property:String):void
		{
			_pt = component[property];
			update();
			
			_x.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_x.enabled = true;
			
			_y.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_y.enabled = true;
		}
		
		private function onUnbind():void
		{
			_pt = null;
			
			_x.enabled = false;
			_x.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			_y.enabled = false;
			_y.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var code:uint = event.keyCode;
			switch (code)
			{
				case Keyboard.ENTER:
					_editing = false;
					_pt.x = Number(_x.text);
					_pt.y = Number(_y.text);
					break;
				case Keyboard.TAB:
					break;
				default:
					_editing = true;
			}
		}
	}
}
