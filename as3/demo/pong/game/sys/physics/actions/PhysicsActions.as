package pong.game.sys.physics.actions
{
	public class PhysicsActions
	{
		private var _stack:Vector.<PhysicsAction>;

		public function PhysicsActions()
		{
			_stack = new Vector.<PhysicsAction>();
		}
		
		public function push(action:PhysicsAction):void
		{
			_stack.push(action);
		}
		
		public function resolve():void
		{
			var count:uint = _stack.length;
			for (var i:int = 0; i < count; i++)
				_stack[i].execute();
			
			_stack.length = 0;
		}
	}
}
