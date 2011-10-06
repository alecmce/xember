package pong.game.ctrl
{
	import pong.game.ctrl.setup.ConfigureSystemsCommand;
	import pong.game.ctrl.setup.CreateBallCommand;
	import pong.game.ctrl.setup.CreateCeilingCommand;
	import pong.game.ctrl.setup.CreateFloorCommand;
	import pong.game.ctrl.setup.CreateLeftPaddleCommand;
	import pong.game.ctrl.setup.CreateLeftSensorCommand;
	import pong.game.ctrl.setup.CreatePhysicsCommand;
	import pong.game.ctrl.setup.CreateRightPaddleCommand;
	import pong.game.ctrl.setup.CreateRightSensorCommand;

	import org.robotlegs.mvcs.Command;

	public class SetupGameCommand extends Command
	{

		override public function execute():void
		{
			commandMap.execute(CreatePhysicsCommand);
			commandMap.execute(CreateFloorCommand);
			commandMap.execute(CreateCeilingCommand);
			commandMap.execute(CreateLeftSensorCommand);
			commandMap.execute(CreateLeftPaddleCommand);
			commandMap.execute(CreateRightPaddleCommand);
			commandMap.execute(CreateRightSensorCommand);
			commandMap.execute(CreateBallCommand);
			commandMap.execute(ConfigureSystemsCommand);
		}

	}
}
