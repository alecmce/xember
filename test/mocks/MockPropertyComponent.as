package mocks
{
	import flash.display.BitmapData;
	
	public class MockPropertyComponent
	{
		public var data:BitmapData;
		
		private var _url:String;
		
		[Ember(inspector="Bitmap")]
		public function get url():String
		{
			return _url;
		}
		
		public function set url(value:String):void
		{
			_url = url;
		}
		
	}
}
