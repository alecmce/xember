package ember
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	final internal class EntitySetFactory
	{
		
		public function generateSet(nodeClass:Class, list:Vector.<ConcreteEntity>):ConcreteEntitySet
		{
			var configuration:EntitySetConfiguration = getClassConfiguration(nodeClass);
			
			var entitySet:ConcreteEntitySet = new ConcreteEntitySet(nodeClass, configuration);
			
			var i:int = list.length;
			while (i--)
			{
				var entity:ConcreteEntity = list[i];
				
				if (configuration.matchesConfiguration(entity))
					entitySet.add(entity);
			}
			
			return entitySet;
		}
		
		public function getClassConfiguration(nodeClass:Class):EntitySetConfiguration
		{
			var node:Node = new nodeClass() as Node;
			if (node == null)
				return null;

			var configuration:EntitySetConfiguration = new EntitySetConfiguration();
			
			var variables:XMLList = describeType(nodeClass).factory.variable;
			for each (var atom:XML in variables)
			{
				var nodeName:String = atom.@name;
				if (nodeName == "next" || nodeName == "prev" || nodeName == "entity")
					continue;

				var attribute:Class = getDefinitionByName(atom.@type) as Class;
				configuration.add(nodeName, attribute);
			}
			
			return configuration;
		}
		
	}
}
