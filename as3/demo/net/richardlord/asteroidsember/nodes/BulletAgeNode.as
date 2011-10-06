package net.richardlord.asteroidsember.nodes
{
	import ember.core.Entity;

	import net.richardlord.asteroidsember.components.Bullet;

	public class BulletAgeNode
	{
		public var entity:Entity;
		
		public var prev:BulletAgeNode;
		public var next:BulletAgeNode;

		[Ember(required)]
		public var bullet:Bullet;

	}
}
