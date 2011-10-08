package ember.io
{
	import ember.core.Entity;
	import ember.core.Ember;
	
	final public class SystemEncoder
	{

		private var _entityEncoder:EntityEncoder;
		
		public function SystemEncoder(entityEncoder:EntityEncoder)
		{
			_entityEncoder = entityEncoder;
		}

		public function encode(ember:Ember):Object
		{
			var entities:Vector.<Entity> = ember.getEntities();
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

		public function decode(ember:Ember, encoded:Object):void
		{
			var entities:Array = encoded.entities;
			
			for each (var object:Object in entities)
				_entityEncoder.decode(ember, object);
		}
		
		

	}
}
