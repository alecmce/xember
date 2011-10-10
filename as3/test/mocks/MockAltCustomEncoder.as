package mocks
{
	public class MockAltCustomEncoder
	{
		public function encode(object:MockCustomVO):Object
		{
			return {label:object.name};
		}
		
		public function decode(object:Object):MockCustomVO
		{
			var vo:MockCustomVO = new MockCustomVO();
			vo.name = object.label;
			return vo;
		}
	}
}
