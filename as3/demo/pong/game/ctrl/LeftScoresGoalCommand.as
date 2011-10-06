package pong.game.ctrl
{
	import Box2D.Dynamics.b2Body;

	import pong.game.events.BallEvent;
	import pong.game.events.GoalEvent;
	import pong.score.events.UpdateScoreEvent;
	import pong.score.model.ScoreModel;

	import org.robotlegs.mvcs.Command;
	
	public class LeftScoresGoalCommand extends Command
	{
		private var _ball:b2Body;
		private var _model:ScoreModel;
		
		public function LeftScoresGoalCommand(event:GoalEvent, model:ScoreModel)
		{
			_ball = event.ball;
			_model = model;
		}

		override public function execute():void
		{
			dispatch(new BallEvent(BallEvent.RESET, _ball));
			
			++_model.leftScore;
			dispatch(new UpdateScoreEvent(UpdateScoreEvent.UPDATE_LEFT_SCORE, _model.leftScore));
		}
		
	}
}
