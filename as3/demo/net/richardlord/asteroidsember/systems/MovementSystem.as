package net.richardlord.asteroidsember.systems
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;

	import net.richardlord.asteroidsember.components.Motion;
	import net.richardlord.asteroidsember.components.Position;
	import net.richardlord.asteroidsember.nodes.MovementNode;
	import net.richardlord.asteroidsember.signals.Move;

	public class MovementSystem
	{
		[Inject]
		public var system:EntitySystem;

		[Inject]
		public var tick:Move;

		private var family:Nodes;

		public function onRegister():void
		{
			family = system.getNodes(MovementNode);
			tick.add(update);
		}

		private function update(time:Number):void
		{
			var node:MovementNode;
			var position:Position;
			var motion:Motion;

			for (node = family.head as MovementNode; node; node = node.next)
			{
				position = node.position;
				motion = node.motion;
				position.position.x += motion.velocity.x * time;
				position.position.y += motion.velocity.y * time;
				if ( position.position.x < 0 )
				{
					position.position.x += 600;
				}
				if ( position.position.x > 600 )
				{
					position.position.x -= 600;
				}
				if ( position.position.y < 0 )
				{
					position.position.y += 450;
				}
				if ( position.position.y > 450 )
				{
					position.position.y -= 450;
				}
				position.rotation += motion.angularVelocity * time;
				if ( motion.damping > 0 )
				{
					var xDamp:Number = Math.abs(Math.cos(position.rotation) * motion.damping * time);
					var yDamp:Number = Math.abs(Math.sin(position.rotation) * motion.damping * time);
					if ( motion.velocity.x > xDamp )
					{
						motion.velocity.x -= xDamp;
					}
					else if ( motion.velocity.x < -xDamp )
					{
						motion.velocity.x += xDamp;
					}
					else
					{
						motion.velocity.x = 0;
					}
					if ( motion.velocity.y > yDamp )
					{
						motion.velocity.y -= yDamp;
					}
					else if ( motion.velocity.y < -yDamp )
					{
						motion.velocity.y += yDamp;
					}
					else
					{
						motion.velocity.y = 0;
					}
				}
			}
		}

		public function dispose():void
		{
			tick.remove(update);
		}
	}
}
