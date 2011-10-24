package inspector.systems
{
	import ember.core.Ember;
	import ember.core.Nodes;

	import inspector.LoopSignals;
	import inspector.components.Movement;
	import inspector.components.SpatialComponent;
	import inspector.components.World;
	import inspector.systems.nodes.PositionNode;
	
	public class PositionSystem
	{
		private var _ember:Ember;
		private var _loop:LoopSignals;
		
		private var _nodes:Nodes;

		public function PositionSystem(ember:Ember, loop:LoopSignals)
		{
			_ember = ember;
			_loop = loop;
		}

		public function onRegister():void
		{
			_nodes = _ember.getNodes(PositionNode);
			_loop.update.add(iterate);
		}

		public function onRemove():void
		{
			_loop.update.remove(iterate);
		}

		private function iterate(time:uint, dt:uint):void
		{
			for (var node:PositionNode = _nodes.head as PositionNode; node; node = node.next)
			{
				var limit:Number;
				var world:World = node.world;
				var movement:Movement = node.movement;
				var spatial:SpatialComponent = node.spatial;
				
				spatial.y += movement.dy;
				
				if (movement.dx > 0)
				{
					spatial.x += movement.dx;
					
					limit = world.size.right - spatial.radius;
					if (spatial.x > limit)
					{
						spatial.x = 2 * limit - spatial.x;
						movement.dx = -movement.dx * world.restitution;
					}
				}
				else if (movement.dx < 0)
				{
					spatial.x += movement.dx;
					
					limit = world.size.left + spatial.radius;
					if (spatial.x < limit)
					{
						spatial.x = 2 * limit - spatial.x;
						movement.dx = -movement.dx * world.restitution;
					}
				}
				
				if (movement.dy > 0)
				{
					spatial.y += movement.dy;
					
					limit = world.size.bottom - spatial.radius;
					if (spatial.y > limit)
					{
						spatial.y = 2 * limit - spatial.y;
						movement.dy = -movement.dy * world.restitution;
					}
				}
				else if (movement.dy < 0)
				{
					spatial.y += movement.dy;
					
					limit = world.size.top + spatial.radius;
					if (spatial.y < limit)
					{
						spatial.y = 2 * limit - spatial.y;
						movement.dy = -movement.dy * world.restitution;
					}
				}
				
				movement.dx += world.gx;
				movement.dy += world.gy;
			}
		}
	}
}
