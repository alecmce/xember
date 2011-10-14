package net.richardlord.asteroidsember.systems
{
	import ember.core.Ember;
	import ember.core.Nodes;

	import net.richardlord.asteroidsember.components.Bullet;
	import net.richardlord.asteroidsember.game.EntityCreator;
	import net.richardlord.asteroidsember.nodes.BulletAgeNode;
	import net.richardlord.asteroidsember.signals.Update;

	public class BulletAgeSystem
	{
		[Inject]
		public var game:Ember;

		[Inject]
		public var entityCreator:EntityCreator;

		[Inject]
		public var tick:Update;

		private var family:Nodes;

		public function onRegister():void
		{
			family = game.getNodes(BulletAgeNode);
			tick.add(update);
		}

		private function update(time:Number):void
		{
			var node:BulletAgeNode;
			var bullet:Bullet;

			for (node = family.head as BulletAgeNode; node; node = node.next)
			{
				bullet = node.bullet;

				bullet.lifeRemaining -= time;
				if ( bullet.lifeRemaining <= 0 )
				{
					entityCreator.destroyEntity(node.entity);
				}
			}
		}

		public function dispose():void
		{
			tick.remove(update);
		}
	}
}
