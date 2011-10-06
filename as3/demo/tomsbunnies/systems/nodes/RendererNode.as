package tomsbunnies.systems.nodes
{
	import ember.core.Entity;
	import tomsbunnies.components.GraphicComponent;
	import tomsbunnies.components.SpatialComponent;
	
	public class RendererNode
	{
		public var entity:Entity;
		
		public var prev:RendererNode;
		public var next:RendererNode;

        [Ember(required)]
		public var spatial:SpatialComponent;
        
        [Ember(required)]
		public var graphic:GraphicComponent;
	}
}