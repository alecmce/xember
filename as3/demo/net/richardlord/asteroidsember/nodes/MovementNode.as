package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Motion;
	import net.richardlord.asteroidsember.components.Position;

	public class MovementNode
	{
		public var prev:MovementNode;
		public var next:MovementNode;

		[Ember(required)]
		public var position:Position;

		[Ember(required)]
		public var motion:Motion;

	}
}
