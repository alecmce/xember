package inspector.util
{
	
	public class RandomColors
	{

		private var _random:Random;

		public function RandomColors(random:Random)
		{
			_random = random;
		}
		
		public function nextColor():uint
		{
			var r:uint = _random.nextInt(0xFF) << 16;
			var g:uint = _random.nextInt(0xFF) << 8;
			var b:uint = _random.nextInt(0xFF);
			
			return 0xFF000000 | r | g | b;
		}

		
	}
}
