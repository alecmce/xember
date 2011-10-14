package ember.inspector.nativeType
{
	import org.osflash.signals.Signal;

	import flash.display.DisplayObject;
	
	public class IntTypeInput implements NativeTypeInput
	{
		public function get self():DisplayObject
		{
			return null;
		}

		public function get enabled():Boolean
		{
			return false;
		}

		public function set enabled(value:Boolean):void
		{
		}

		public function get focus():Boolean
		{
			return false;
		}

		public function set focus(value:Boolean):void
		{
		}

		public function get value():*
		{
		}

		public function set value(value:*):void
		{
		}

		public function get changed():Signal
		{
			return null;
		}
		
	}
}
