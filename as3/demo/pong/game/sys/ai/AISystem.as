package pong.game.sys.ai
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;

	import ember.core.Game;
	import ember.core.Entity;
	import ember.core.Nodes;

	import pong.game.Names;
	import pong.game.Tick;
	import pong.game.attr.AIComponent;
	import pong.game.attr.PhysicalComponent;
	
	public class AISystem
	{
		private var _game:Game;
		private var _tick:Tick;
		
		private var physicalBall:PhysicalComponent;
		private var velocity:b2Vec2;
		
		private var _nodes:Nodes;

		public function AISystem(game:Game, tick:Tick)
		{
			_game = game;
			_tick = tick;
		}
		
		public function onRegister():void
		{
			var ball:Entity = _game.getEntity(Names.BALL);
			if (!ball)
				return;
			
			physicalBall = ball.getComponent(PhysicalComponent) as PhysicalComponent;
			
			_tick.add(iterate);
			
			velocity = new b2Vec2();
			
			_nodes = _game.getNodes(AINode);
		}

		public function onRemove():void
		{
			_tick.remove(iterate);
		}

		private function iterate():void
		{
			for (var node:AINode = _nodes.head as AINode; node; node = node.next)
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
			}
		}
	}
}
