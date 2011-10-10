package mocks
{
	public class MockCustomEncoder
	{
		public function encode(object:MockCustomVO):Object
		{
			return object.id + "/" + object.name;
		}
		
		public function decode(object:Object):MockCustomVO
		{
			var data:Array = object.split("/");
			
			var vo:MockCustomVO = new MockCustomVO();
			vo.id = data.shift();
			vo.name = data.join("");
			return vo;
		}
	}
}
