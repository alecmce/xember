package tomsbunnies.events 
{
	import org.osflash.signals.Signal;
	
	public class Pause extends Signal 
	{
		
		public function Pause() 
		{
			super(Boolean);
		}
		
	}

}