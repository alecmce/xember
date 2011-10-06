package pong.game.sys.ai
{
	import pong.game.attr.AIComponent;
	import pong.game.attr.PhysicalComponent;
	
	public class AINode
	{
		public var prev:AINode;
		public var next:AINode;

        [Ember(required)]
		public var ai:AIComponent;
        
        [Ember(required)]
		public var physical:PhysicalComponent;
	}
}
