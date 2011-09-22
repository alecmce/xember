package pong.sys.ai
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;

	import alecmce.time.Time;

	import ember.Entity;
	import ember.EntitySet;
	import ember.EntitySystem;

	import pong.Names;
	import pong.attr.AIAttribute;
	import pong.attr.PhysicalAttribute;
	
	public class AISystem
	{
		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var entitySet:EntitySet;
		
		[Inject]
		public var time:Time;
		
		private var physicalBall:PhysicalAttribute;
		
		public function onRegister():void
		{
			var ball:Entity = system.getEntity(Names.BALL);
			if (!ball)
				return;
			
			physicalBall = ball.getAttribute(PhysicalAttribute) as PhysicalAttribute;
			
			time.tick.add(iterate);
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
					return;

				var ai:AIAttribute = node.ai;
				var body:b2Body = node.physical.body;
				var pos:b2Vec2 = body.GetPosition();
				
				var dy:Number = 0;
				
				var y:Number = ball.GetPosition().y - pos.y;
				if (y < -ai.dy)
					dy = -ai.dy;
				else if (y > ai.dy)
					dy = ai.dy;
				else
					dy = y;
					
				pos.y += dy;
				body.SetPosition(pos);
				
				node = node.next as AINode;
			}
		}
	}
}
