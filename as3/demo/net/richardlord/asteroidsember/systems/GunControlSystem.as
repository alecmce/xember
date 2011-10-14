package net.richardlord.asteroidsember.systems
{
	import ember.core.Game;
	import ember.core.Nodes;

	import net.richardlord.asteroidsember.components.Gun;
	import net.richardlord.asteroidsember.components.GunControls;
	import net.richardlord.asteroidsember.components.Position;
	import net.richardlord.asteroidsember.game.EntityCreator;
	import net.richardlord.asteroidsember.nodes.GunControlNode;
	import net.richardlord.asteroidsember.signals.Update;
	import net.richardlord.utils.KeyPoll;

	public class GunControlSystem
	{
		[Inject]
		public var game:Game;

		[Inject]
		public var tick:Update;

		[Inject]
		public var entityCreator:EntityCreator;

		[Inject]
		public var keyPoll:KeyPoll;

		private var family:Nodes;

		public function onRegister():void
		{
			family = game.getNodes(GunControlNode);
			tick.add(update);
		}

		private function update(time:Number):void
		{
			var node:GunControlNode;
			var control:GunControls;
			var position:Position;
			var gun:Gun;

			for (node = family.head as GunControlNode; node; node = node.next)
			{
				control = node.control;
				gun = node.gun;
				position = node.position;

				gun.shooting = keyPoll.isDown(control.trigger);
				gun.timeSinceLastShot += time;
				if ( gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval )
				{
					entityCreator.createUserBullet(gun, position);
					gun.timeSinceLastShot = 0;
				}
			}
		}

		public function dispose():void
		{
			tick.remove(update);
		}
	}
}
