package inspector
{
	import flash.display.Sprite;

	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="640", height="480")]
	public class InspectorDemo extends Sprite
	{
		
		private var context:InspectorContext;
		
		public function InspectorDemo()
		{
			context = new InspectorContext(this);
		}
	}
}
