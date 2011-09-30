package pong.game.sys.physics
{
	import Box2D.Dynamics.b2World;
	import ember.core.EntitySystem;
	import ember.core.Nodes;
	import pong.game.Tick;
	import pong.game.attr.PhysicalComponent;
	import pong.game.sys.physics.actions.PhysicsActions;

	public class PhysicsSystem
	{
		private static const INV_FPS:Number = 1 / 60;
		
		[Inject]
		public var system:EntitySystem;

		[Inject]
		public var tick:Tick;
		
		[Inject]
		public var config:PhysicsConfig;
		
		[Inject]
		public var actions:PhysicsActions;
		
		private var world:b2World;
		
		private var _nodes:Nodes;
		
		public function onRegister():void
		{
			world = config.world;
			
			tick.add(iterate);
			
			_nodes = system.getNodes(PhysicsNode);
			_nodes.nodeAdded.add(onNodeAdded);
			_nodes.nodeRemoved.add(onNodeRemoved);

			for (var node:PhysicsNode = _nodes.head; node; node = node.next)
			{
				onNodeAdded(node);
			}
		}

		public function onRemove():void
		{
			tick.remove(iterate);
			
			_nodes.nodeAdded.remove(onNodeAdded);
			_nodes.nodeRemoved.remove(onNodeRemoved);
		}

		private function onNodeAdded(node:PhysicsNode):void
		{
			var physical:PhysicalComponent = node.physical;
			physical.body = world.CreateBody(physical.def);
			physical.body.CreateFixture(physical.fixture);
		}

		private function onNodeRemoved(node:PhysicsNode):void
		{
			var physical:PhysicalComponent = node.physical;
			world.DestroyBody(physical.body);
			physical.body = null;
		}
		
		private function iterate():void
		{
			world.Step(INV_FPS, 4, 2);
			world.ClearForces();
			actions.resolve();
		}
		
	}
}
