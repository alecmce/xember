package alecmce.notice
{
	public class NoticeDispatcher implements Notice, Dispatcher
	{
		
		private var singular:SingularListeners;
		private var listeners:Listeners;
		
		public function NoticeDispatcher()
		{
			singular = new SingularListeners();
			listeners = new Listeners();
		}
		
		final public function add(listener:Function):Boolean
		{
			if (singular.contains(listener))
				throw new Error("Cannot add a listener that has already been addOnced");
			
			return listeners.add(listener);
		}

		final public function addOnce(listener:Function):Boolean
		{
			if (listeners.contains(listener))
				throw new Error("Cannot addOnce a listener that has already been added");
			
			return singular.add(listener);
		}

		final public function remove(listener:Function):Boolean
		{
			return singular.remove(listener) || listeners.remove(listener);
		}
		
		final public function removeAll():void
		{
			singular.removeAll();
			listeners.removeAll();
		}
		
		final public function dispatch(...params):void
		{
			listeners.dispatch(params);
			singular.dispatch(params);
		}
		
	}
}
