package tomsbunnies.systems.nodes
{
	import tomsbunnies.components.SpatialComponent;

	public class SpatialNode
	{
		public var prev:SpatialNode;
		public var next:SpatialNode;

        [Ember(required)]
		public var spatial:SpatialComponent;
	}
	
}