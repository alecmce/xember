package ember.inspector
{
	import flash.display.DisplayObject;
	
	public interface PropertyInspector
	{
		
		function get self():DisplayObject;
		
		function bind(component:Object, property:String):void;
		function unbind():void;
		
		function update():void;
		
	}
}
