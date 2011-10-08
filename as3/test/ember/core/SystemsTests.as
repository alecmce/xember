package ember.core
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.robotlegs.adapters.SwiftSuspendersInjector;

	public class SystemsTests
	{
		private var _systems:Systems;
		
		[Before]
		public function before():void
		{
			_systems = new Systems(new SwiftSuspendersInjector());
		}
		
		[After]
		public function after():void
		{
			_systems = null;
		}
		
		[Test]
		public function can_add_anything_that_ducktypes_as_a_system():void
		{
			assertThat(_systems.add(MockSystem), isA(MockSystem));
		}
		
		[Test]
		public function duck_typed_system_requires_onRegister_method():void
		{
			assertThat(missing_onRegister_fails, throws(Error));
		}
		private function missing_onRegister_fails():void
		{
			_systems.add(MockNoOnRegister);
		}
		
		[Test]
		public function duck_typed_system_does_not_require_onRemove_method():void
		{
			assertThat(_systems.add(MockNoOnRemove), isA(MockNoOnRemove));
		}
		
		[Test]
		public function after_adding_a_system_can_check_via_has_method():void
		{
			_systems.add(MockSystem);
			assertThat(_systems.has(MockSystem), isTrue());
		}
		
		[Test]
		public function can_get_an_added_system():void
		{
			_systems.add(MockSystem);
			var mock:Object = _systems.get(MockSystem);
			assertThat(mock, isA(MockSystem));
		}
		
		[Test]
		public function can_remove_a_system():void
		{
			_systems.add(MockSystem);
			_systems.remove(MockSystem);
			assertThat(_systems.has(MockSystem), isFalse());
		}
		
		[Test]
		public function when_a_system_is_added_onRegister_is_called():void
		{
			var mock:MockSystem = _systems.add(MockSystem) as MockSystem;
			assertThat(mock.wasRegistered, isTrue());
		}
		
		[Test]
		public function when_a_system_is_removed_onRemove_is_called():void
		{
			var mock:MockSystem = _systems.add(MockSystem) as MockSystem;
			_systems.remove(MockSystem);
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