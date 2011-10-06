package ember.core
{
	import asunit.asserts.assertThrows;
	import mocks.MockMissingOnRegisterSystem;
	import mocks.MockMissingOnRemoveSystem;
	import mocks.MockRenderSystem;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.core.IInjector;


	
	internal class SystemsTest
	{
		private var system:Systems;
		
		[Before]
		public function before():void
		{
			var injector:IInjector = new SwiftSuspendersInjector();
			system = new Systems(injector);
		}
		
		[After]
		public function after():void
		{
			system = null;
		}
		
		[Test]
		public function can_add_anything_that_ducktypes_as_a_system():void
		{
			system.addSystem(MockRenderSystem);
		}
		
		[Test]
		public function duck_typed_system_requires_onRegister_method():void
		{
			assertThrows(Error, missing_onRegister_fails);
		}
		private function missing_onRegister_fails():void
		{
			system.addSystem(MockMissingOnRegisterSystem);
		}
		
		[Test]
		public function duck_typed_system_requires_onRemove_method():void
		{
			assertThrows(Error, missing_onRemove_fails);
		}
		private function missing_onRemove_fails():void
		{
			system.addSystem(MockMissingOnRemoveSystem);
		}
		
	}
}
