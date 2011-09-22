package alecmce.time.pause
{
	
	final public class ExtrinsicTimeStrategy implements PauseStrategy
	{

		public function getTimeAtResume(timeAtPause:uint, pauseDuration:int):uint
		{
			return timeAtPause;
		}
		
	}
}
