package tomsbunnies
{
	import alecmce.profiling.RacetrackStats;

	import flash.display.Sprite;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="640", height="480")]
	public class TomsBunnies extends Sprite
	{
		private static const STATS:RacetrackStats = new RacetrackStats();
		
		private var context:TomsBunniesContext;
		
		public function TomsBunnies()
		{
			context = new TomsBunniesContext(this);
			
			addChild(STATS);
		}
		
	}
}