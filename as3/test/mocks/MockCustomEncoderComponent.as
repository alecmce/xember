package mocks
{
	
	[Ember(encodeAll)]
	public class MockCustomEncoderComponent
	{
		public var normal:String;
		
		[Ember(encoder="mocks::MockCustomEncoder")]
		public var custom:MockCustomVO;
		
	}
}
