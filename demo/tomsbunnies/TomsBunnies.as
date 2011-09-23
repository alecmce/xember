package tomsbunnies
{
	import flash.display.Sprite;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="640", height="480")]
	public class TomsBunnies extends Sprite
	{
		
		private var context:TomsBunniesContext;
		
		public function TomsBunnies()
		{
			context = new TomsBunniesContext(this);
			
//			addChild(new Stats());
		}
		
	}
}