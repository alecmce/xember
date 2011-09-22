package alecmce.time.clock
{
	import alecmce.notice.Notice;
	import alecmce.notice.NoticeDispatcher;
	
	public class Appointment
	{
		
		internal var prev:Appointment;
		internal var next:Appointment;
		internal var clock:Clock;
		internal var time:uint;
		
		private var _seconds:uint;
		private var _repeat:uint;
		private var _data:*;
		
		private var _alarm:NoticeDispatcher;

		public function Appointment(seconds:uint, repeat:uint = 0, data:* = null)
		{
			_seconds = seconds;
			_repeat = repeat;
			_data = data;
			
			_alarm = new NoticeDispatcher();
		}
		
		public function get remaining():int
		{
			return clock ? ((time - clock.now()) * 0.001) | 0 : -1;
		}
		
		public function get alarm():Notice
		{
			return _alarm;
		}

		public function get seconds():uint
		{
			return _seconds;
		}

		public function get repeat():uint
		{
			return _repeat;
		}

		internal function trigger():Boolean
		{
			if (_data)
				_alarm.dispatch(this, _data);
			else
				_alarm.dispatch(this);
			
			if (_repeat == 0)
				return false;
			
			if (_repeat == -1)
				return true;
			
			return _repeat-- > 0;
		}
		
	}
	
}
