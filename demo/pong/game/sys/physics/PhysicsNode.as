package pong.game.sys.physics
{
	import pong.game.attr.PhysicalComponent;
	
	public class PhysicsNode
	{
		public var prev:PhysicsNode;
		public var next:PhysicsNode;
		
		public var physical:PhysicalComponent;
	}
}
