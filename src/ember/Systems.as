package ember
{
	import org.robotlegs.core.IInjector;
	
	final internal class Systems
	{
		private var _sets:EntitySets;
		private var _injector:IInjector;
		
		public function Systems(entitySets:EntitySets, injector:IInjector)
		{
			_sets = entitySets;
			_injector = injector;
		}
		
		public function add(systemClass:Class, nodeClass:Class = null):void
		{
			var system:Object;
			
			if (nodeClass == null)
				system = createSystem(systemClass);
			else
				system = createSystemWithInjectedNodes(systemClass, nodeClass);
			
			system.onRegister();
		}

		private function createSystem(systemClass:Class):Object
		{
			return _injector.instantiate(systemClass);
		}

		private function createSystemWithInjectedNodes(systemClass:Class, nodeClass:Class):Object
		{
			var entitySet:EntitySet = _sets.get(nodeClass);
			_injector.mapValue(EntitySet, entitySet);
			
			var system:Object = createSystem(systemClass);
			
			_injector.unmap(EntitySet);
			
			return system;
		}
		
	}
}
