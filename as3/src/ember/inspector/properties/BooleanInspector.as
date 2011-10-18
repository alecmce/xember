package ember.inspector.properties
{
	import ember.inspector.PropertyInspector;

	import com.bit101.components.PushButton;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class BooleanInspector implements PropertyInspector
	{
		private var _self:Sprite;
		private var _button:PushButton;
		
		private var _component:Object;
		private var _property:String;
		private var _bound:Boolean;

		public function BooleanInspector()
		{
			_self = new Sprite();
			
			_button = new PushButton(_self);
			_button.toggle = true;
			_button.enabled = false;
			_button.tabEnabled = false;
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
			_bound = false;
			onUnbind();
		}
		
		public function update():void
		{
			if (!_bound)
				return;
			
			var value:Boolean = _component[_property];
			_button.selected = value;
			_button.label = value ? "true" : "false";
		}
		
		private function onBind(component:Object, property:String):void
		{
			_component = component;
			_property = property;
			update();
			
			_button.enabled = true;
			_button.tabEnabled = true;
			_button.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onUnbind():void
		{
			_component = null;
			_property = null;
			
			_button.enabled = false;
			_button.tabEnabled = false;
			_button.removeEventListener(MouseEvent.CLICK, onClick);	
		}
		
		private function onClick(event:MouseEvent):void 
		{
			toggleValue();
		}
		
		private function toggleValue():void
		{
			var value:Boolean = _button.selected;
			_component[_property] = !value;
			update();
		}
		
	}
}
