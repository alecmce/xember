package ember
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	final internal class EntitySetFactory
	{
		private var _nodeClassConfigurations:Dictionary;
		
		public function EntitySetFactory()
		{
			_nodeClassConfigurations = new Dictionary();
		}
		
		public function generateSet(nodeClass:Class, list:Vector.<ConcreteEntity>):ConcreteEntitySet
		{
			var configuration:EntitySetConfig = getClassConfiguration(nodeClass);
			
			var entitySet:ConcreteEntitySet = new ConcreteEntitySet(nodeClass, configuration);
			
			var len:int = list.length;
			for (var i:int = 0; i < len; i++)
			{
				var entity:ConcreteEntity = list[i];
				
				if (configuration.matchesConfiguration(entity))
					entitySet.add(entity);
			}
			
			return entitySet;
		}
		
		public function getClassConfiguration(nodeClass:Class):EntitySetConfig
		{
			var config:EntitySetConfig = _nodeClassConfigurations[nodeClass];
			if (config)
				return config;
			
			var variables:XMLList = describeType(nodeClass)["factory"].variable;
			if (!checkNodeClassDuckType(variables, nodeClass))
				throw new Error(nodeClass + " is not a valid EntitySet node");
			
			_nodeClassConfigurations[nodeClass] = config = generateConfig(variables, nodeClass);
			return config;
		}

		private function generateConfig(variables:XMLList, nodeClass:Class):EntitySetConfig
		{
			var config:EntitySetConfig = new EntitySetConfig();
			config.nodeClass = nodeClass;
			for each (var atom:XML in variables)
			{
				var nodeName:String = atom.@name;
				if (nodeName == "next" || nodeName == "prev")
					continue;

				var component:Class = getDefinitionByName(atom.@type) as Class;
				if (component == Entity)
					config.entityField = atom.@name;
				else
					config.add(nodeName, component);
			}
			
			return config;
		}
		
		private function checkNodeClassDuckType(variables:XMLList, nodeClass:Class):Boolean
		{
			var atom:XML;
		
			atom = variables.(@name == "prev")[0];
			if (!atom || getDefinitionByName(atom.@type) != nodeClass)
				return false;
			
			atom = variables.(@name == "next")[0];
			if (!atom || getDefinitionByName(atom.@type) != nodeClass)
				return false;
			
			return true;
		}
		
		
	}
}
