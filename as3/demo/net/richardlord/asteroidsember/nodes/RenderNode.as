package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Display;
	import net.richardlord.asteroidsember.components.Position;

	public class RenderNode
	{
		public var prev:RenderNode;
		public var next:RenderNode;
		
		[Ember(required)]
		public var position:Position;
		
		[Ember(required)]
		public var display:Display;
		
	}
}
