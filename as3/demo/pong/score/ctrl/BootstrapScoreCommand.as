package pong.score.ctrl
{
	import pong.score.ScoreMediator;
	import pong.score.model.ScoreModel;
	import pong.score.view.ScoreView;

	import org.robotlegs.mvcs.Command;
	
	public class BootstrapScoreCommand extends Command
	{
		
		override public function execute():void
		{
			mediatorMap.mapView(ScoreView, ScoreMediator);
			
			injector.mapSingleton(ScoreModel);
		}
		
	}
}
