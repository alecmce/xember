package alecmce.notice
{
	final public class Listeners
	{
		
		private var _dimension:uint;
		
		private var _size:uint;
		private var _listeners:Vector.<Function>;
		private var _count:uint;
		
		private var _lock:Boolean;
		private var _removals:Vector.<Function>;

		private var i:int, j:int;

		public function Listeners()
		{
			_dimension = 1;
			_size = 1 << _dimension;
			_listeners = new Vector.<Function>(_size, true);
			_count = 0;
			
			_lock = false;
			_removals = new Vector.<Function>();
		}

		public function add(listener:Function):Boolean
		{
			var i:int = _listeners.indexOf(listener);
			if (i != -1)
				return false;
			
			if (_count == _size)
			{
				_size = 1 << ++_dimension;
				
				_listeners.fixed = false;
				_listeners.length = _size;
				_listeners.fixed = true;
			}
			
			_listeners[_count++] = listener;
			return true;
		}
		
		public function contains(listener:Function):Boolean
		{
			return _listeners.indexOf(listener) != -1;
		}
		
		public function remove(listener:Function):Boolean
		{
			var i:int = _listeners.indexOf(listener);
			if (i == -1)
				return false;
			
			if (_lock)
			{
				if (_removals.indexOf(listener) != -1)
					return false;
				
				_removals.push(listener);
				return true;
			}
			
			_listeners[i] = _listeners[--_count];
			_listeners[_count] = null;
			return true;
		}
		
		public function removeAll():void
		{
			var i:int = _count;
			
			if (_lock)
			{
				while (i--)
				{
					var listener:Function = _listeners[i];
					if (_removals.indexOf(listener) == -1)
						_removals.push(_listeners[i]);
				}
			}
			
			_count = 0;
			while (i--)
				_listeners[i] = null;
		}
		
		public function dispatch(params:Array):void
		{
			if (_lock)
				return;
			
			_lock = true;
			
			i = _count;
			for (i = 0; i < _count; i++)
				_listeners[i].apply(null, params);
			
			_lock = false;
			
			i = _removals.length;
			if (i == 0)
				return;
			
			while (i--)
			{
				j = _listeners.indexOf(_removals[i]);
				_listeners[j] = _listeners[--_count];
				_listeners[_count] = null;
			}
			
			_removals.length = 0;
		}
		
	}
}
