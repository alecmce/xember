package pong.game.sys.render
{
	import pong.game.attr.PhysicalComponent;
	import pong.game.attr.RenderComponent;


	public class RenderNode
	{
		public var prev:RenderNode;
		public var next:RenderNode;

        [Ember(required)]
		public var physical:PhysicalComponent;
        
        [Ember(required)]
		public var render:RenderComponent;
	}
}
