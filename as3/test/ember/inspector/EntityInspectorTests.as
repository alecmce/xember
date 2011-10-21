package ember.inspector
{
	
	public class EntityInspectorTests
	{
		private var inspector:EntityInspector;
		
		[Before]
		public function before():void
		{
			
		}
		
		[After]
		public function after():void
		{
			
		}
		
		[Test]
		public function can_create_an_entity_inspector():void
		{
			inspector = new EntityInspector();	// should this come from a factory?
		}
		
	}
}
