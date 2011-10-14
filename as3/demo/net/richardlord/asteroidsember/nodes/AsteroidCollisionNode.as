package net.richardlord.asteroidsember.nodes
{
	import ember.core.Entity;

	import net.richardlord.asteroidsember.components.Asteroid;
	import net.richardlord.asteroidsember.components.Position;

	public class AsteroidCollisionNode
	{
		public var entity:Entity;
		
		public var prev:AsteroidCollisionNode;
		public var next:AsteroidCollisionNode;
		
		[Ember(required)]
		public var asteroid:Asteroid;
		
		[Ember(required)]
		public var position:Position;
		
	}
}
