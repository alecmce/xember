package tomsbunnies.systems.nodes
{
	import ember.Entity;

	import tomsbunnies.components.GraphicComponent;
	import tomsbunnies.components.SpatialComponent;

	public class RendererNode
	{
		public var entity:Entity;
		
		public var prev:RendererNode;
		public var next:RendererNode;
		
		public var spatial:SpatialComponent;
		public var graphic:GraphicComponent;
	}
}