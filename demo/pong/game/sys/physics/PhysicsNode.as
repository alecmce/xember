package pong.game.sys.physics
{
	import pong.game.attr.PhysicalComponent;
	
	public class PhysicsNode
	{
		public var prev:PhysicsNode;
		public var next:PhysicsNode;
		
		[Ember(required)]
		public var physical:PhysicalComponent;
	}
}
