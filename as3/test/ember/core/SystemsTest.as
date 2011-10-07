package ember.core
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertThrows;
	import asunit.asserts.assertTrue;

	import mocks.MockMissingOnRegisterSystem;
	import mocks.MockMissingOnRemoveSystem;
	import mocks.MockRenderSystem;
	import mocks.MockSystem;

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
			system.add(MockRenderSystem);
		}
		
		[Test]
		public function duck_typed_system_requires_onRegister_method():void
		{
			assertThrows(Error, missing_onRegister_fails);
		}
		private function missing_onRegister_fails():void
		{
			system.add(MockMissingOnRegisterSystem);
		}
		
		[Test]
		public function duck_typed_system_requires_onRemove_method():void
		{
			assertThrows(Error, missing_onRemove_fails);
		}
		private function missing_onRemove_fails():void
		{
			system.add(MockMissingOnRemoveSystem);
		}
		
		[Test]
		public function can_add_a_system():void
		{
			system.add(MockRenderSystem);
			assertTrue(system.has(MockRenderSystem));
		}
		
		[Test]
		public function can_get_an_added_system():void
		{
			system.add(MockRenderSystem);
			var render:Object = system.get(MockRenderSystem);
			assertTrue(render is MockRenderSystem);
		}
		
		[Test]
		public function can_remove_a_system():void
		{
			system.add(MockRenderSystem);
			system.remove(MockRenderSystem);
			assertFalse(system.has(MockRenderSystem));
		}
		
		[Test]
		public function when_a_system_is_added_onRegister_is_called():void
		{
			system.add(MockSystem);
			var mock:MockSystem = system.get(MockSystem) as MockSystem;
			assertTrue(mock.wasRegistered);
		}
		
		[Test]
		public function when_a_system_is_removed_onRemove_is_called():void
		{
			system.add(MockSystem);
			var mock:MockSystem = system.get(MockSystem) as MockSystem;
			system.remove(MockSystem);
			assertTrue(mock.wasRemoved);
		}
		
	}
}
