package pong.game.sys.render
{
	import pong.game.attr.PhysicalComponent;
	import pong.game.attr.RenderComponent;


	public class RenderNode
	{
		public var prev:RenderNode;
		public var next:RenderNode;
		
		public var physical:PhysicalComponent;
		public var render:RenderComponent;
	}
}
