package pong.attr
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	public class PhysicalAttribute
	{
		public var def:b2BodyDef;
		public var fixture:b2FixtureDef;
		
		public var body:b2Body;
	}
}
