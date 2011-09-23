package tomsbunnies.systems.nodes
{
	import ember.Node;
	import tomsbunnies.components.GraphicComponent;
	import tomsbunnies.components.SpatialComponent;

	
	public class RendererNode extends Node
	{
		public var spatial:SpatialComponent;
		public var graphic:GraphicComponent;
	}
}