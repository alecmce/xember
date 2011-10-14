package ember.core
{
	import org.robotlegs.core.IInjector;

	import flash.utils.Dictionary;
	
	final internal class Systems
	{
		private var _injector:IInjector;
		private var _systems:Dictionary;
		
		public function Systems(injector:IInjector)
		{
			_injector = injector;
			_systems = new Dictionary();
		}
		
		public function add(systemClass:Class):Object
		{
			var system:Object = _systems[systemClass];
			if (system)
				throw new Error("System already exists - Unable to add multiple instances of the same system");
			
			system = _injector.instantiate(systemClass);
			_systems[systemClass] = system;
			system.onRegister();
			return system;
		}

		public function has(systemClass:Class):Boolean
		{
			return _systems[systemClass] != null;
		}

		public function get(systemClass:Class):Object
		{
			return _systems[systemClass];
		}

		public function remove(systemClass:Class):Boolean
		{
			var system:Object = _systems[systemClass];
			if (!system)
				return false;
			
			delete _systems[systemClass];
			system.hasOwnProperty("onRemove") && system.onRemove();
			
			return true;
		}
	}
}
