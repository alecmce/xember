package ember.io
{
	import ember.core.Ember;
	import ember.core.Entity;
	
	final public class EmberEncoder
	{

		private var _configFactory:ComponentConfigFactory;
		private var _componentEncoder:ComponentEncoder;
		private var _entityEncoder:EntityEncoder;
		
		public function EmberEncoder()
		{
			_configFactory = new ComponentConfigFactory();
			_componentEncoder = new ComponentEncoder(_configFactory);
			_entityEncoder = new EntityEncoder(_componentEncoder);
		}

		public function addCustomEncoder(encoder:Class):void
		{
			_componentEncoder.addCustomEncoder(encoder);
		}
		
		public function removeCustomEncoder(encoder:Class):void
		{
			_componentEncoder.removeCustomEncoder(encoder);
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
