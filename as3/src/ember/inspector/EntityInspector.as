package ember.inspector
{
	import com.bit101.components.Label;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class EntityInspector
	{
		private var _self:Sprite;
		private var _title:Label;
		private var _inner:Sprite;
		private var _height:uint;
		
		private var _components:Dictionary;
		
		public function EntityInspector()
		{
			_self = new Sprite();
			_title = new Label(_self);
			_title.width = 300;
			
			_inner = new Sprite();
			_inner.y = _title.height;
			_self.addChild(_inner);
			
			_height = 0;
			
			_components = new Dictionary();
		}
		
		public function get self():DisplayObject
		{
			return _self;
		}

		public function get title():String
		{
			return _title.text;
		}
		
		public function set title(title:String):void
		{
			_title.text = title;
		}
		
		public function addComponent(component:Class, inspector:ComponentInspector):void
		{
			_components[component] = inspector;
			
			_inner.addChild(inspector.self);
			_height += inspector.self.height;
		}

		public function removeComponent(component:Class):void
		{
			var inspector:ComponentInspector = _components[component];
			if (!inspector)
				return;
			
			delete _components[component];

			var self:DisplayObject = inspector.self;
			var i:int = _inner.getChildIndex(self);
			var dheight:int = self.height;
			
			_height -= dheight;
			_inner.removeChild(self);
			
			var numChildren:uint = _inner.numChildren;
			for (i; i < numChildren; i++)
				_inner.getChildAt(i).y -= dheight;
		}
		
		public function getComponent(component:Class):ComponentInspector
		{
			return _components[component];
		}

		public function dispose():void
		{
			// TODO
		}

	}
}
