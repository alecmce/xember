package alecmce.notice
{
	final public class SingularListeners
	{
		
		private var _dimension:uint;
		private var _size:uint;
		private var _listeners:Vector.<Function>;
		private var _count:uint;
		
		private var _lock:Boolean;
		private var _additions:Vector.<Function>;

		private var i:int;
		private var fn:Function;

		public function SingularListeners()
		{
			_dimension = 1;
			_size = 1 << _dimension;
			_listeners = new Vector.<Function>(_size, true);
			_count = 0;
			
			_additions = new Vector.<Function>();
			_lock = false;
		}

		public function add(listener:Function):Boolean
		{
			if (_lock)
			{
				if (_additions.indexOf(listener) != -1)
					return false;
				
				_additions.push(listener);
				return true;
			}
			
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
				return true;
			
			_listeners[i] = _listeners[--_count];
			_listeners[_count] = null;
			return true;
		}
		
		public function removeAll():void
		{
			if (_lock)
				return;
			
			var i:int = _count;
			_count = 0;
			
			while (i--)
				_listeners[i] = null;
		}
		
		public function dispatch(params:Array):void
		{
			if (_lock)
				return;
			
			_lock = true;
			
			for (i = 0; i < _count; i++)
			{
				fn = _listeners[i];
				_listeners[i] = null;
				fn.apply(null, params);
			}
			
			_lock = false;
			
			_count = _additions.length;
			if (_count == 0)
				return;
			
			while (_count >= _size)
			{
				_size = 1 << ++_dimension;
				
				_listeners.fixed = false;
				_listeners.length = _size;
				_listeners.fixed = true;
			}
			
			i = _count;
			while (i--)
				_listeners[i] = _additions[i];
			
			_additions.length = 0;
		}
		
	}
}
