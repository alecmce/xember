package ember
{
	import org.robotlegs.core.IInjector;

	import flash.utils.Dictionary;
	
	final internal class Systems
	{
		private var _systems:Dictionary;
		private var _injector:IInjector;
		
		public function Systems(injector:IInjector)
		{
			_systems = new Dictionary();
			_injector = injector;
		}
		
		public function addSystem(systemClass:Class):void
		{
			var system:Object = _injector.instantiate(systemClass);
			
			system.onRegister();
		}
		
	}
}
