package net.richardlord.asteroidsember.nodes
{
	import net.richardlord.asteroidsember.components.Gun;
	import net.richardlord.asteroidsember.components.GunControls;
	import net.richardlord.asteroidsember.components.Position;

	public class GunControlNode
	{
		public var prev:GunControlNode;
		public var next:GunControlNode;

		[Ember(required)]
		public var control:GunControls;
		
		[Ember(required)]
		public var gun:Gun;
		
		[Ember(required)]
		public var position:Position;
	}
}
