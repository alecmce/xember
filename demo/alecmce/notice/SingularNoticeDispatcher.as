package alecmce.notice
{
	public class SingularNoticeDispatcher implements SingularNotice, Dispatcher
	{
		
		private var singular:SingularListeners;
		
		public function SingularNoticeDispatcher()
		{
			singular = new SingularListeners();
		}

		final public function addOnce(listener:Function):Boolean
		{
			return singular.add(listener);
		}

		final public function remove(listener:Function):Boolean
		{
			return singular.remove(listener);
		}

		final public function removeAll():void
		{
			singular.removeAll();
		}

		final public function dispatch(...params):void
		{
			singular.dispatch(params);
		}
		
	}
}
