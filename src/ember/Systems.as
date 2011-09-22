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
		
		public function add(systemClass:Class, nodeClass:Class):void
		{
			var entitySet:EntitySet = _sets.get(nodeClass);
			
			_injector.mapValue(EntitySet, entitySet);
			var system:Object = _injector.instantiate(systemClass);
			_injector.unmap(EntitySet);
			
			system.onRegister();
		}
		
	}
}
