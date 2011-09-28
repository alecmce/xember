package pong.game
{
	import org.osflash.signals.Signal;

	import flash.display.Shape;
	import flash.events.Event;

	public class Tick extends Signal
	{
		public function Tick()
		{
			var shape:Shape = new Shape();
			shape.addEventListener(Event.ENTER_FRAME, iterate);
		}

		private function iterate(event:Event):void
		{
			dispatch();
		}
	}
}
