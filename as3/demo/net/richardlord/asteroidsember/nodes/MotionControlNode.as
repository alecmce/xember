package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Motion;
	import net.richardlord.asteroidsember.components.MotionControls;
	import net.richardlord.asteroidsember.components.Position;

	public class MotionControlNode
	{
		public var prev:MotionControlNode;
		public var next:MotionControlNode;

		[Ember(required)]
		public var control:MotionControls;

		[Ember(required)]
		public var position:Position;
		
		[Ember(required)]
		public var motion:Motion;

	}
}
