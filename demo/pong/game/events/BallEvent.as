package pong.game.events
{
	import Box2D.Dynamics.b2Body;

	import flash.events.Event;

	public class BallEvent extends Event
	{
		public static const RESET:String = "RESET";
		
		public var ball:b2Body;
		
		public function BallEvent(type:String, ball:b2Body)
		{
			super(type, false, false);
			this.ball = ball;
		}
	}
}
