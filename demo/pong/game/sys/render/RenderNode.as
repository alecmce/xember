package pong.game.sys.render
{
	import ember.Node;
	import pong.game.attr.PhysicalComponent;
	import pong.game.attr.RenderComponent;


	public class RenderNode extends Node
	{
		public var physical:PhysicalComponent;
		public var render:RenderComponent;
	}
}
