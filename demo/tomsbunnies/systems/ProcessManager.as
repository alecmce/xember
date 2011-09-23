package tomsbunnies.systems
{

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.getTimer;
	import tomsbunnies.events.Pause;
	import tomsbunnies.events.Render;
	import tomsbunnies.events.Tick;


	/**
	 * handles the ai and render loop
	 * @author Tom Davies
	 */
	public class ProcessManager
	{
		private const TO_SECONDS:Number = 1 / 1000;

		private var _startTime:uint;

		[Inject]
		public var viewContext:DisplayObjectContainer;

		[Inject]
		public var gameTick:Tick;

		[Inject]
		public var render:Render;

		[Inject]
		public var pause:Pause;

		private var _paused:Boolean;

		public function onRegister():void
		{
			_startTime = getTimer();
			viewContext.addEventListener(Event.ENTER_FRAME, frameHandler);
			pause.add(onPause);
		}

		private function onPause(paused:Boolean):void
		{
			_paused = paused;
		}

		private function frameHandler(e:Event):void
		{
			var time:uint = getTimer();
			var t:Number = (time - _startTime) * TO_SECONDS;
			_startTime = time;
			
			if (!_paused)
				gameTick.dispatch(t);
				
			render.dispatch();
		}

		public function dispose():void
		{
			viewContext.removeEventListener(Event.ENTER_FRAME, frameHandler);
			pause.remove(onPause);
			viewContext = null;
		}

	}

}