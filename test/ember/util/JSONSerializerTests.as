package ember.util
{
	import ember.Entity;
	import ember.EntitySystem;
	import ember.mocks.MockRenderComponent;

	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.core.IInjector;
	
	public class JSONSerializerTests
	{
		private var serializer:JSONSerializer;
		
		[Before]
		public function before():void
		{
			serializer = new JSONSerializer();
		}
		
		[After]
		public function after():void
		{
			serializer = null;
		}
		
		[Test]
		public function simple_serialization():void
		{
			var injector:IInjector = new SwiftSuspendersInjector();
			var system:EntitySystem = new EntitySystem(injector);

			var entity:Entity = system.createEntity();
			entity.addComponent(new MockRenderComponent());
		}
		
	}
}
