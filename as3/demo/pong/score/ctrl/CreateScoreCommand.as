package pong.score.ctrl
{
	import pong.score.view.ScoreView;

	import org.robotlegs.mvcs.Command;

	import flash.display.DisplayObjectContainer;
	
	public class CreateScoreCommand extends Command
	{

		private var _view:DisplayObjectContainer;

		public function CreateScoreCommand(view:DisplayObjectContainer)
		{
			_view = view;
		}
		
		override public function execute():void
		{
			var score:ScoreView = new ScoreView();
			_view.addChild(score);
		}
				
	}
}
