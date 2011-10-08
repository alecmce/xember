package mocks
{
	public class MockSystem
	{
		public var wasRegistered:Boolean;
		public var wasRemoved:Boolean;

		public function onRegister():void
		{
			wasRegistered = true;
		}

		public function onRemove():void
		{
			wasRemoved = true;
		}
	}
}
