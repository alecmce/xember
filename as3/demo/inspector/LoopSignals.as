package inspector
{
	import org.osflash.signals.Signal;
	
	public class LoopSignals
	{
		
		public var first:Signal;
		public var input:Signal;
		public var update:Signal;
		public var render:Signal;
		public var last:Signal;

		public function LoopSignals()
		{
			first = new Signal();
			input = new Signal();
			update = new Signal();
			render = new Signal();
			last = new Signal();
		}

		public function iterate(time:int, dt:int):void
		{
			first.dispatch(time, dt);
			input.dispatch(time, dt);
			update.dispatch(time, dt);
			render.dispatch(time, dt);
			last.dispatch(time, dt);
		}
		
	}
}
