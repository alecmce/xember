package pong.score.events
{
	import flash.events.Event;

	public class UpdateScoreEvent extends Event
	{
		public static const UPDATE_LEFT_SCORE:String = "UpdateScoreEvent.UPDATE_LEFT_SCORE";
		public static const UPDATE_RIGHT_SCORE:String = "UpdateScoreEvent.UPDATE_RIGHT_SCORE";

		public var score:uint;
		
		public function UpdateScoreEvent(type:String, score:uint)
		{
			super(type, false, false);
			this.score = score;
		}
	}
}
