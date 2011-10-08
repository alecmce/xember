package ember.core
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
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
			assertThat(system.add(MockSystem), isA(MockSystem));
		}
		
		[Test]
		public function duck_typed_system_requires_onRegister_method():void
		{
			assertThat(missing_onRegister_fails, throws(Error));
		}
		private function missing_onRegister_fails():void
		{
			system.add(MockNoOnRegister);
		}
		
		[Test]
		public function duck_typed_system_requires_onRemove_method():void
		{
			assertThat(missing_onRemove_fails, throws(Error));
		}
		private function missing_onRemove_fails():void
		{
			system.add(MockNoOnRemove);
		}
		
		[Test]
		public function after_adding_a_system_can_check_via_has_method():void
		{
			system.add(MockSystem);
			assertThat(system.has(MockSystem), isTrue());
		}
		
		[Test]
		public function can_get_an_added_system():void
		{
			system.add(MockSystem);
			var mock:Object = system.get(MockSystem);
			assertThat(mock, isA(MockSystem));
		}
		
		[Test]
		public function can_remove_a_system():void
		{
			system.add(MockSystem);
			system.remove(MockSystem);
			assertThat(system.has(MockSystem), isFalse());
		}
		
		[Test]
		public function when_a_system_is_added_onRegister_is_called():void
		{
			var mock:MockSystem = system.add(MockSystem) as MockSystem;
			assertThat(mock.wasRegistered, isTrue());
		}
		
		[Test]
		public function when_a_system_is_removed_onRemove_is_called():void
		{
			var mock:MockSystem = system.add(MockSystem) as MockSystem;
			system.remove(MockSystem);
			assertThat(mock.wasRemoved, isTrue());
		}
		
	}
}

class MockSystem
{
	public var wasRemoved:Boolean;
	public var wasRegistered:Boolean;
	
	public function onRegister():void
	{
		wasRegistered = true;
	}
	
	public function onRemove():void
	{
		wasRemoved = true;
	}
}

class MockNoOnRegister
{
	
	public function onRemove():void {}
	
}

class MockNoOnRemove
{
	
	public function onRegister():void {}
	
}