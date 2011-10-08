package ember.io
{
	import ember.core.Entity;
	import ember.core.Ember;
	import mocks.MockComponent;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.robotlegs.adapters.SwiftSuspendersInjector;

	public class EmberEncoderTests
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
			
			var a:Ember = createEmber();
			component = createEntityWithComponent(a);
			component.n = 5;
			
			var b:Ember = createEmber();
			component = createEntityWithComponent(b);
			component.n = 5;
			
			assertThat(CompareVOs.objectsAreEquivalent(encoder.encode(a), encoder.encode(b)), isTrue());
		}
		
		[Test]
		public function encodes_different_systems_differently():void
		{
			var component:MockComponent;
			
			var a:Ember = createEmber();
			component = createEntityWithComponent(a);
			component.n = 5;
			
			var b:Ember = createEmber();
			component = createEntityWithComponent(b);
			component.n = 6;
			
			assertThat(CompareVOs.objectsAreEquivalent(encoder.encode(a), encoder.encode(b)), isFalse());
		}
		
		[Test]
		public function encode_and_decode_roundtrips():void
		{
			var a:Ember = createEmber();
			a.createEntity();
			a.createEntity();
			a.createEntity();
			a.createEntity();

			var encoded:Object = encoder.encode(a);

			var b:Ember = createEmber();
			encoder.decode(b, encoded);
			
			assertThat(b.getEntities().length, equalTo(4));
		}
		
		private function createEmber():Ember
		{
			return new Ember(new SwiftSuspendersInjector());
		}
		
		private function createEntityWithComponent(ember:Ember):MockComponent
		{
			var entity:Entity = ember.createEntity();
			var component:MockComponent = new MockComponent();
			entity.addComponent(component);
			
			return component;
		}
		
	}
}
