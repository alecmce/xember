package pong.game.sys.ai
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;

	import alecmce.time.Time;

	import ember.Entity;
	import ember.EntitySet;
	import ember.EntitySystem;

	import pong.game.Names;
	import pong.game.attr.AIComponent;
	import pong.game.attr.PhysicalComponent;
	
	public class AISystem
	{
		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var entitySet:EntitySet;
		
		[Inject]
		public var time:Time;
		
		private var physicalBall:PhysicalComponent;
		private var velocity:b2Vec2;
		
		public function onRegister():void
		{
			var ball:Entity = system.getEntity(Names.BALL);
			if (!ball)
				return;
			
			physicalBall = ball.getComponent(PhysicalComponent) as PhysicalComponent;
			
			time.tick.add(iterate);
			
			velocity = new b2Vec2();
		}

		public function onRemove():void
		{
			time.tick.remove(iterate);
		}

		private function iterate(time:uint):void
		{
			var node:AINode = entitySet.head as AINode;
			while (node)
			{
				var ball:b2Body = physicalBall.body;
				if (ball.GetLinearVelocity().x < 0)
				{
					velocity.y = 0;
				}
				else
				{
					var ai:AIComponent = node.ai;
					var pos:b2Vec2 = node.physical.body.GetPosition();
					
					var y:Number = ball.GetPosition().y - pos.y;
					if (y < -ai.dy)
						velocity.y = -ai.dy;
					else if (y > ai.dy)
						velocity.y = ai.dy;
					else
						velocity.y = y;
				}
				
				node.physical.body.SetLinearVelocity(velocity);
				
				node = node.next as AINode;
			}
		}
	}
}
