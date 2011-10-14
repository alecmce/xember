package net.richardlord.asteroidsember.nodes
{
	import ember.core.Entity;

	import net.richardlord.asteroidsember.components.Bullet;
	import net.richardlord.asteroidsember.components.Position;

	public class BulletCollisionNode
	{
		public var entity:Entity;
		
		public var prev:BulletCollisionNode;
		public var next:BulletCollisionNode;

		[Ember(required)]
		public var bullet:Bullet;

		[Ember(required)]
		public var position:Position;

	}
}
