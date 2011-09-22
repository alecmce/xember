package pong.game.ctrl
{
	import Box2D.Dynamics.b2Body;

	import pong.game.events.BallEvent;
	import pong.game.sys.physics.PhysicsConfig;
	import pong.game.sys.physics.actions.PhysicsActions;
	import pong.game.sys.physics.actions.ResetBallAction;
	
	public class ResetBallCommand
	{
		private var _ball:b2Body;
		private var _actions:PhysicsActions;
		private var _config:PhysicsConfig;
		
		public function ResetBallCommand(event:BallEvent, actions:PhysicsActions, config:PhysicsConfig)
		{
			_ball = event.ball;
			_actions = actions;
			_config = config;
		}
		
		public function execute():void
		{
			_actions.push(new ResetBallAction(_ball, _config));
		}
		
	}
}
