package ember.io
{
	import ember.core.Entity;
	import ember.core.EntitySystem;
	import mocks.MockComponent;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.robotlegs.adapters.SwiftSuspendersInjector;

	
	public class SystemEncoderTests
	{
		private var encoder:SystemEncoder;
		
		[Before]
		public function before():void
		{
			var configFactory:ComponentConfigFactory = new ComponentConfigFactory();
			var componentEncoder:ComponentEncoder = new ComponentEncoder(configFactory);
			var entityEncoder:EntityEncoder = new EntityEncoder(componentEncoder);
			encoder = new SystemEncoder(entityEncoder);
		}
		
		[After]
		public function after():void
		{
			encoder = null;
		}
		
		[Test]
		public function encodes_similar_systems_identically():void
		{
			var component:MockComponent;
			
			var a:EntitySystem = createSystem();
			component = createEntityWithComponent(a);
			component.n = 5;
			
			var b:EntitySystem = createSystem();
			component = createEntityWithComponent(b);
			component.n = 5;
			
			assertThat(CompareVOs.objectsAreEquivalent(encoder.encode(a), encoder.encode(b)), isTrue());
		}
		
		[Test]
		public function encodes_different_systems_differently():void
		{
			var component:MockComponent;
			
			var a:EntitySystem = createSystem();
			component = createEntityWithComponent(a);
			component.n = 5;
			
			var b:EntitySystem = createSystem();
			component = createEntityWithComponent(b);
			component.n = 6;
			
			assertThat(CompareVOs.objectsAreEquivalent(encoder.encode(a), encoder.encode(b)), isFalse());
		}
		
		[Test]
		public function encode_and_decode_roundtrips():void
		{
			var a:EntitySystem = createSystem();
			a.createEntity();
			a.createEntity();
			a.createEntity();
			a.createEntity();

			var encoded:Object = encoder.encode(a);

			var b:EntitySystem = createSystem();
			encoder.decode(b, encoded);
			
			assertThat(b.getEntities().length, equalTo(4));
		}
		
		private function createSystem():EntitySystem
		{
			return new EntitySystem(new SwiftSuspendersInjector());
		}
		
		private function createEntityWithComponent(system:EntitySystem):MockComponent
		{
			var entity:Entity = system.createEntity();
			var component:MockComponent = new MockComponent();
			entity.addComponent(component);
			
			return component;
		}
		
	}
}
