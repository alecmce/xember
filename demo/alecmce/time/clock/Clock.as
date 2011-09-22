package alecmce.time.clock
{
	import alecmce.time.Time;
	
	public class Clock
	{
		private var _time:Time;
		
		private var head:Appointment;
		private var tail:Appointment;
		
		private var node:Appointment;
		private var next:Appointment;
		
		public function Clock(time:Time)
		{
			_time = time;
		}
		
		public function now():uint
		{
			return _time.now;
		}
		
		public function add(vo:Appointment):Boolean
		{
			if (!vo || (vo.clock && vo.clock != this))
				return false;
						
			if (!head)
				_time.tick.add(iterate);
			
			positionInList(vo, _time.now);
			return true;
		}
		
		public function remove(vo:Appointment):Boolean
		{
			if (!vo || !vo.clock || vo.clock != this)
				return false;
			
			removeFromList(vo);
			
			if (!head)
				_time.tick.remove(iterate);
			
			return true;
		}
		
		private function iterate(time:uint):void
		{
			node = head;
			
			while (node && node.time <= time)
			{
				next = node.next;
				
				removeFromList(node);
				if (node.trigger())
					positionInList(node, time);
				
				node = next;
			}
			
			if (!head)
				_time.tick.remove(iterate);
		}
		
		private function positionInList(vo:Appointment, t:uint):void
		{
			t += vo.seconds * 1000;
			
			vo.clock = this;
			vo.time = t;
			
			if (head)
			{
				var node:Appointment = head;
				while (node && node.time < t)
					node = node.next;
				
				if (node)
				{
					vo.prev = node.prev;
					vo.next = node;
					node.prev = vo;
					
					if (vo.prev)
						vo.prev.next = vo;
						
					if (node == head)
						head = vo;
				}
				else
				{
					vo.prev = tail;
					tail.next = vo;
					tail = vo;
				}
			}
			else
			{
				head = tail = vo;
			}
		}
		
		private function removeFromList(vo:Appointment):void
		{
			vo.clock = null;
			
			if (tail == vo)
				tail = vo.prev;
			
			if (head == vo)
				head = vo.next;
			
			if (vo.prev)
			{
				vo.prev.next = vo.next;
				vo.prev = null;
			}
			
			if (vo.next)
			{
				vo.next.prev = vo.prev;
				vo.next = null;
			}
		}
		
	}
	
}
