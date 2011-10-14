package ember.inspector.nativeType
{
	import org.osflash.signals.Signal;

	import flash.display.DisplayObject;
	
	public interface NativeTypeInput
	{
		
		function get self():DisplayObject;
		
		function get enabled():Boolean;
		function set enabled(value:Boolean):void;
		
		function get focus():Boolean;
		function set focus(value:Boolean):void;
		
		function get value():*;
		function set value(value:*):void;
		
		function get changed():Signal;
		
	}
}
