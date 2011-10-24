package inspector.systems.nodes
{
	import inspector.components.World;
	import inspector.components.Movement;
	import inspector.components.SpatialComponent;
	
	public class PositionNode
	{
		
		public var prev:PositionNode;
		public var next:PositionNode;
		
		[Ember(required)]
		public var world:World;
		
		[Ember(required)]
		public var spatial:SpatialComponent;
		
		[Ember(required)]
		public var movement:Movement;
		
	}
}
