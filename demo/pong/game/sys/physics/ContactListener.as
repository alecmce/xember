package pong.game.sys.physics
{
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;

	import pong.game.Names;
	import pong.game.events.GoalEvent;

	import flash.events.IEventDispatcher;
	
	public class ContactListener extends b2ContactListener
	{
		private var _eventDispatcher:IEventDispatcher;

		public function ContactListener(eventDispatcher:IEventDispatcher)
		{
			_eventDispatcher = eventDispatcher;
		}
		
		override public function BeginContact(contact:b2Contact):void
		{
			var a:b2Fixture = contact.GetFixtureA();
			var b:b2Fixture = contact.GetFixtureB();
			
			if (a.IsSensor())
				checkSensor(a.GetUserData(), b.GetBody());
			else if (b.IsSensor())
				checkSensor(b.GetUserData(), a.GetBody());
		}

		private function checkSensor(id:String, body:b2Body):void
		{
			switch (id)
			{
				case Names.LEFT:
					_eventDispatcher.dispatchEvent(new GoalEvent(GoalEvent.RIGHT_SCORES, body));
					break;
				case Names.RIGHT:
					_eventDispatcher.dispatchEvent(new GoalEvent(GoalEvent.LEFT_SCORES, body));
					break;
			}
		}
		
	}
}
