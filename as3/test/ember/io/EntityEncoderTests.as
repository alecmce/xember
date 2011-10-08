package ember.io
{
	import ember.core.Entity;
	import ember.core.Ember;

	import mocks.MockComponent;
	import mocks.MockTextComponent;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.robotlegs.adapters.SwiftSuspendersInjector;

	
	public class EntityEncoderTests
	{
		private var encoder:EntityEncoder;
		
		[Before]
		public function before():void
		{
			var configFactory:ComponentConfigFactory = new ComponentConfigFactory();
			var componentEncoder:ComponentEncoder = new ComponentEncoder(configFactory);
			
			encoder = new EntityEncoder(componentEncoder);
		}
		
		[After]
		public function after():void
		{
			encoder = null;
		}
		
		[Test]
		public function encodes_equivalent_entities_equivalently():void
		{
			var a:Entity = createEntity();
			addMockComponent(a).n = 5;
			addMockTextComponent(a).str = "test";
			
			var b:Entity = createEntity();
			addMockComponent(b).n = 5;
			addMockTextComponent(b).str = "test";
			
			assertThat(CompareVOs.objectsAreEquivalent(encoder.encode(a), encoder.encode(b)), isTrue());
		}
		
		[Test]
		public function encodes_different_entities_differently():void
		{
			var a:Entity = createEntity();
			addMockComponent(a).n = 6;
			addMockTextComponent(a).str = "test";
			
			var b:Entity = createEntity();
			addMockComponent(b).n = 5;
			addMockTextComponent(b).str = "test";
			
			assertThat(CompareVOs.objectsAreEquivalent(encoder.encode(a), encoder.encode(b)), isFalse());
		}
		
		[Test]
		public function decode_reverses_encode():void
		{
			var entity:Entity = createEntity();
			addMockComponent(entity).n = 6;
			addMockTextComponent(entity).str = "test";
			
			var encoded:Object = encoder.encode(entity);
			var ember:Ember = createEmber();
			var roundtrip:Entity = encoder.decode(ember, encoded);
			
			var value:int = (roundtrip.getComponent(MockComponent) as MockComponent).n;
			var text:String = (roundtrip.getComponent(MockTextComponent) as MockTextComponent).str;
			
			assertThat(value, equalTo(6));
			assertThat(text, equalTo("test"));
		}

		[Test]
		public function encoding_roundtrip_preserves_naming():void
		{
			var entity:Entity = createEntity("name");
			var object:Object = encoder.encode(entity);

			var ember:Ember = createEmber();
			var roundtrip:Entity = encoder.decode(ember, object);
			
			assertThat(roundtrip.name, equalTo("name"));
		}
		
		private function createEmber():Ember
		{
			return new Ember(new SwiftSuspendersInjector());
		}
		
		private function createEntity(name:String = ""):Entity
		{
			var ember:Ember = createEmber();
			return ember.createEntity(name);
		}
		
		private function addMockComponent(entity:Entity):MockComponent
		{
			var component:MockComponent = new MockComponent();
			entity.addComponent(component);
			
			return component;
		}
		
		private function addMockTextComponent(entity:Entity):MockTextComponent
		{
			var component:MockTextComponent = new MockTextComponent();
			entity.addComponent(component);
			
			return component;
		}
		
	}
}
