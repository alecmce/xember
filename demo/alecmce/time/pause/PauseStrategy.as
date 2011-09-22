package alecmce.time.pause
{
	public interface PauseStrategy
	{
		
		function getTimeAtResume(timeAtPause:uint, pauseDuration:int):uint;
		
	}
}
