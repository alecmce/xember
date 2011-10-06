package pong.game.sys.physics.actions
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;

	import pong.game.sys.physics.PhysicsConfig;
	
	public class ResetBallAction extends PhysicsAction
	{
		private var _ball:b2Body;
		private var _config:PhysicsConfig;
		
		public function ResetBallAction(ball:b2Body, config:PhysicsConfig)
		{
			_ball = ball;
			_config = config;
		}
		
		override public function execute():void
		{
			var toMeters:Number = _config.toMeters;
			
			var x:Number = 200 + Math.random() * 400;
			var y:Number = 200 + Math.random() * 200;
			var a:Number = Math.random() * Math.PI * 0.5 - 0.25;
			var ax:Number = 400 * Math.cos(a);
			var ay:Number = 400 * Math.sin(a);
			var b:Number = Math.random() * Math.PI - Math.PI;
			
			_ball.SetPosition(new b2Vec2(x * toMeters, y * toMeters));
			_ball.SetLinearVelocity(new b2Vec2(ax * toMeters, ay * toMeters));
			_ball.SetAngularVelocity(b);
		}

		
	}
}
