package alecmce.time.pause
{
	
	final public class IntrinsicTimeStrategy implements PauseStrategy
	{

		public function getTimeAtResume(timeAtPause:uint, pauseDuration:int):uint
		{
			return timeAtPause + pauseDuration;
		}
		
	}
}
