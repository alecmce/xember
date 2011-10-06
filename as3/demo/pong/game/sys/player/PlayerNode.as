package pong.game.sys.player
{
	import pong.game.attr.PhysicalComponent;
	import pong.game.attr.PlayerComponent;

	
	public class PlayerNode
	{
		public var prev:PlayerNode;
		public var next:PlayerNode;

        [Ember(required)]
		public var player:PlayerComponent;
        
        [Ember(required)]
		public var physical:PhysicalComponent;
	}
}
