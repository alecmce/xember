package net.richardlord.asteroidsember.nodes
{
	import ember.core.Entity;

	import net.richardlord.asteroidsember.components.Position;
	import net.richardlord.asteroidsember.components.Spaceship;

	public class SpaceshipCollisionNode
	{
		public var entity:Entity;
		
		public var prev:SpaceshipCollisionNode;
		public var next:SpaceshipCollisionNode;

		[Ember(required)]
		public var spaceship:Spaceship;
		
		[Ember(required)]
		public var position:Position;

	}
}
