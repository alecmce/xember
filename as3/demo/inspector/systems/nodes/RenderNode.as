package inspector.systems.nodes
{
	import inspector.components.RenderComponent;
	import inspector.components.SpatialComponent;
	
	public class RenderNode
	{
		public var prev:RenderNode;
		public var next:RenderNode;
		
		[Ember(required)]
		public var spatial:SpatialComponent;
		
		[Ember(required)]
		public var render:RenderComponent;
		
	}
}
