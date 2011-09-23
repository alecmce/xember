package pong.game.sys.player
{
	import ember.Node;
	import pong.game.attr.PhysicalComponent;
	import pong.game.attr.PlayerComponent;

	
	public class PlayerNode extends Node
	{
		public var player:PlayerComponent;
		public var physical:PhysicalComponent;
	}
}
