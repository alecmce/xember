package alecmce.time
{
	import alecmce.notice.Notice;
	import alecmce.notice.NoticeDispatcher;

	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.getTimer;


	final public class Timeline implements Time
	{
		private var _shape:Shape;
		private var _tick:NoticeDispatcher;
		
		private var _time:uint;
		private var _dtime:uint;
		private var _now:uint;
		
		private var _speed:Number;

		public function Timeline()
		{
			_shape = new Shape();
			
			_tick = new NoticeDispatcher();
			
			_speed = 0;
		}
		
		public function set now(value:uint):void
		{
			if (_now == value)
				return;
			
			_now = value;
			_tick.dispatch(_now);
		}
		
		public function get now():uint
		{
			return _now;
		}

		public function play():void
		{
			this.speed = 1;
		}
		
		public function stop():void
		{
			this.speed = 0;
		}

		public function get speed():Number
		{
			return _speed;
		}
		
		public function set speed(value:Number):void
		{
			if (_speed == value)
				return;
			
			if (_speed == 0)
			{
				_shape.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				_time = getTimer();
			}
			
			_speed = value;
			
			if (_speed == 0)
				_shape.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function get tick():Notice
		{
			return _tick;
		}
		
		private function onEnterFrame(event:Event):void
		{
			_dtime = _time;
			_time = getTimer();
			_dtime = (_time - _dtime) * _speed;
			
			if (_now + _dtime < 0)
			{
				speed = 0;
				_now = 0;
			}
			else
				_now += _dtime;
			
			_tick.dispatch(_now);
		}
		
	}
}
