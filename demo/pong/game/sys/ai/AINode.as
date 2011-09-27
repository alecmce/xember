package pong.game.sys.ai
{
	import pong.game.attr.AIComponent;
	import pong.game.attr.PhysicalComponent;
	
	public class AINode
	{
		public var prev:AINode;
		public var next:AINode;
		
		public var ai:AIComponent;
		public var physical:PhysicalComponent;
	}
}
