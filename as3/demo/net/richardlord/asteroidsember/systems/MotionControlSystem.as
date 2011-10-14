package net.richardlord.asteroidsember.systems
{
	import ember.core.Ember;
	import ember.core.Nodes;

	import net.richardlord.asteroidsember.components.Motion;
	import net.richardlord.asteroidsember.components.MotionControls;
	import net.richardlord.asteroidsember.components.Position;
	import net.richardlord.asteroidsember.nodes.MotionControlNode;
	import net.richardlord.asteroidsember.signals.Update;
	import net.richardlord.utils.KeyPoll;

	import flash.display.DisplayObjectContainer;

	public class MotionControlSystem
	{
		[Inject]
		public var game:Ember;

		[Inject]
		public var tick:Update;

		[Inject]
		public var contextView:DisplayObjectContainer;

		[Inject]
		public var keyPoll:KeyPoll;

		private var family:Nodes;

		public function onRegister():void
		{
			family = game.getNodes(MotionControlNode);
			tick.add(update);
		}

		private function update(time:Number):void
		{
			var node:MotionControlNode;
			var control:MotionControls;
			var position:Position;
			var motion:Motion;

			for (node = family.head as MotionControlNode; node; node = node.next)
			{
				control = node.control;
				position = node.position;
				motion = node.motion;

				if ( keyPoll.isDown(control.left) )
				{
					position.rotation -= control.rotationRate * time;
				}

				if ( keyPoll.isDown(control.right) )
				{
					position.rotation += control.rotationRate * time;
				}

				if ( keyPoll.isDown(control.accelerate) )
				{
					motion.velocity.x += Math.cos(position.rotation) * control.accelerationRate * time;
					motion.velocity.y += Math.sin(position.rotation) * control.accelerationRate * time;
				}
			}
		}

		public function dispose():void
		{
			tick.remove(update);
		}
	}
}
