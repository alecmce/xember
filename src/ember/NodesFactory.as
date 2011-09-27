package ember
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	final internal class NodesFactory
	{
		private var _nodeClassConfigurations:Dictionary;
		
		public function NodesFactory()
		{
			_nodeClassConfigurations = new Dictionary();
		}
		
		public function generateSet(nodeClass:Class, list:Vector.<Entity>):Nodes
		{
			var configuration:NodesConfig = getClassConfiguration(nodeClass);
			
			var entitySet:Nodes = new Nodes(nodeClass, configuration);
			
			var len:int = list.length;
			for (var i:int = 0; i < len; i++)
			{
				var entity:Entity = list[i];
				
				if (configuration.matchesConfiguration(entity))
					entitySet.add(entity);
			}
			
			return entitySet;
		}
		
		public function getClassConfiguration(nodeClass:Class):NodesConfig
		{
			var config:NodesConfig = _nodeClassConfigurations[nodeClass];
			if (config)
				return config;
			
			var variables:XMLList = describeType(nodeClass)["factory"].variable;
			if (!checkNodeClassDuckType(variables, nodeClass))
				throw new Error(nodeClass + " is not a valid EntitySet node");
			
			_nodeClassConfigurations[nodeClass] = config = generateConfig(variables, nodeClass);
			return config;
		}

		private function generateConfig(variables:XMLList, nodeClass:Class):NodesConfig
		{
			var config:NodesConfig = new NodesConfig();
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
