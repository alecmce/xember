package ember.io
{
	import ember.core.Entity;
	import ember.core.Ember;
	
	final public class EntityEncoder
	{
		private var _componentEncoder:ComponentEncoder;
		
		public function EntityEncoder(componentEncoder:ComponentEncoder)
		{
			_componentEncoder = componentEncoder;
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

		public function decode(system:Ember, object:Object):Entity
		{
			var name:String = object["name"] || "";
			var entity:Entity = system.createEntity(name);

			var list:Object = object.components;
			for each (var component:Object in list)
				entity.addComponent(_componentEncoder.decode(component));
			
			return entity;
		}
		
	}
}
