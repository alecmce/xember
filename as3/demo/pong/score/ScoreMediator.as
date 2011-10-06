package pong.score
{
	import pong.score.events.UpdateScoreEvent;
	import pong.score.view.ScoreView;

	import org.robotlegs.mvcs.Mediator;
	
	public class ScoreMediator extends Mediator
	{
		
		private var _view:ScoreView;

		public function ScoreMediator(view:ScoreView)
		{
			_view = view;
		}
		
		override public function onRegister():void
		{
			eventDispatcher.addEventListener(UpdateScoreEvent.UPDATE_LEFT_SCORE, updateLeftScore);
			eventDispatcher.addEventListener(UpdateScoreEvent.UPDATE_RIGHT_SCORE, updateRightScore);
		}
		
		override public function onRemove():void
		{
			eventDispatcher.removeEventListener(UpdateScoreEvent.UPDATE_LEFT_SCORE, updateLeftScore);
			eventDispatcher.removeEventListener(UpdateScoreEvent.UPDATE_RIGHT_SCORE, updateRightScore);
		}
		
		private function updateLeftScore(event:UpdateScoreEvent):void
		{
			_view.left = event.score;
		}

		private function updateRightScore(event:UpdateScoreEvent):void
		{
			_view.right = event.score;
		}
		
	}
}
