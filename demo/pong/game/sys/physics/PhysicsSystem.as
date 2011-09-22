package pong.game.sys.physics
{
	import Box2D.Dynamics.b2World;

	import alecmce.time.Time;

	import ember.EntitySet;

	import pong.game.attr.PhysicalAttribute;
	import pong.game.sys.physics.actions.PhysicsActions;

	public class PhysicsSystem
	{
		private static const INV_FPS:Number = 1 / 60;
		
		[Inject]
		public var nodes:EntitySet;

		[Inject]
		public var time:Time;
		
		[Inject]
		public var config:PhysicsConfig;
		
		[Inject]
		public var actions:PhysicsActions;
		
		private var world:b2World;
		
		public function onRegister():void
		{
			world = config.world;
			
			time.tick.add(iterate);
			
			nodes.nodeAdded.add(onNodeAdded);
			nodes.nodeRemoved.add(onNodeRemoved);

			var node:PhysicsNode = nodes.head as PhysicsNode;
			while (node)
			{
				onNodeAdded(node);
				node = node.next as PhysicsNode;
			}
		}

		public function onRemove():void
		{
			time.tick.remove(iterate);
			
			nodes.nodeAdded.remove(onNodeAdded);
			nodes.nodeRemoved.remove(onNodeRemoved);
		}

		private function onNodeAdded(node:PhysicsNode):void
		{
			var physical:PhysicalAttribute = node.physical;
			physical.body = world.CreateBody(physical.def);
			physical.body.CreateFixture(physical.fixture);
		}

		private function onNodeRemoved(node:PhysicsNode):void
		{
			var physical:PhysicalAttribute = node.physical;
			world.DestroyBody(physical.body);
			physical.body = null;
		}
		
		private function iterate(time:uint):void
		{
			world.Step(INV_FPS, 4, 2);
			world.ClearForces();
			actions.resolve();
		}
		
	}
}
