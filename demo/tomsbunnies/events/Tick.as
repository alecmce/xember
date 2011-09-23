package tomsbunnies.events
{
	import org.osflash.signals.Signal;
	
	public class Tick extends Signal
	{
		public function Tick()
		{
			super(Number);
		}
	}
}