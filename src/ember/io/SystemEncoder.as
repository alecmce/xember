package ember.io
{
	import ember.core.Entity;
	import ember.core.EntitySystem;
	
	public class SystemEncoder
	{

		private var _entityEncoder:EntityEncoder;
		
		public function SystemEncoder(entityEncoder:EntityEncoder)
		{
			_entityEncoder = entityEncoder;
		}

		public function encode(system:EntitySystem):Object
		{
			var entities:Vector.<Entity> = system.getEntities();
			var count:uint = entities.length;
			
			var output:Array = [];
			for (var i:int = 0; i < count; i++)
			{
				var entity:Entity = entities[i];
				var encoded:Object = _entityEncoder.encode(entity);
				output.push(encoded);
			}
			
			return {entities:output};
		}

		public function decode(system:EntitySystem, encoded:Object):void
		{
			var entities:Array = encoded.entities;
			
			for each (var object:Object in entities)
				_entityEncoder.decode(system, object);
		}
		
		

	}
}
