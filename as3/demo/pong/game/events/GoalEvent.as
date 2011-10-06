package pong.game.events
{
	import Box2D.Dynamics.b2Body;

	import flash.events.Event;

	public class GoalEvent extends Event
	{
		public static const LEFT_SCORES:String = "GoalEvent.LEFT_SCORES";
		public static const RIGHT_SCORES:String = "GoalEvent.RIGHT_SCORES";

		public var ball:b2Body;
		
		public function GoalEvent(type:String, ball:b2Body)
		{
			super(type, false, false);
			this.ball = ball;
		}
	}
}
