package pong.game.ctrl
{
	import ember.core.Ember;
	import org.robotlegs.mvcs.Command;
	import pong.game.events.BallEvent;
	import pong.game.events.GoalEvent;
	import pong.game.sys.physics.PhysicsConfig;
	import pong.game.sys.physics.actions.PhysicsActions;



	public class BootstrapGameCommand extends Command
	{
		
		override public function execute():void
		{
			injector.mapSingleton(PhysicsConfig);
			injector.mapSingleton(PhysicsActions);
			injector.mapValue(Ember, new Ember(injector));
			
			commandMap.mapEvent(GoalEvent.LEFT_SCORES, LeftScoresGoalCommand);
			commandMap.mapEvent(GoalEvent.RIGHT_SCORES, RightScoresGoalCommand);
			commandMap.mapEvent(BallEvent.RESET, ResetBallCommand);
		}
		
	}
}
