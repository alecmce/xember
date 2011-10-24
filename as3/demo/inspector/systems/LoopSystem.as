package inspector.systems
{
	import ember.core.Ember;

	import inspector.LoopSignals;

	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class LoopSystem
	{
		private var _ember:Ember;
		private var _signals:LoopSignals;
		
		private var _time:int;
		private var _shape:Shape;
		
		public function LoopSystem(ember:Ember, signals:LoopSignals)
		{
			_ember = ember;
			_signals = signals;
		}

		public function onRegister():void
		{
			_time = getTimer();
			_shape = new Shape();
			_shape.addEventListener(Event.ENTER_FRAME, iterate);
		}

		public function onRemove():void
		{
			_shape.removeEventListener(Event.ENTER_FRAME, iterate);
		}
		
		private function iterate(event:Event):void
		{
			var t:int = getTimer();
			var dt:int = t - _time;
			
			_time = t;
			_signals.iterate(_time, dt);
		}
		
		
	}
}
