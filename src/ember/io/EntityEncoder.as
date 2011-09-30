package ember.io
{
	import ember.core.Entity;
	
	public class EntityEncoder
	{
		private var _componentEncoder:ComponentEncoder;
		
		public function EntityEncoder()
		{
			_componentEncoder = new ComponentEncoder();
		}
		
		public function encode(entity:Entity):Object
		{
			var components:Vector.<Object> = entity.getComponents();
			
			var list:Array = [];
			for each (var component:Object in components)
				list.push(_componentEncoder.encode(component));
			
			var output:Object = {components:list};
			if (entity.name)
				output.name = entity.name;
			
			return output;
		}
		
	}
}
