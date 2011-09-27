package ember
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertNotSame;
	import asunit.asserts.assertSame;
	import asunit.asserts.assertThrows;
	import asunit.asserts.assertTrue;
	
	public class EntitiesTests
	{
		private static const BRIAN:String = "brian";
		
		private var entities:Entities;
		
		[Before]
		public function before():void
		{
			entities = new Entities();
		}
		
		[After]
		public function after():void
		{
			entities = null;
		}
		
		[Test]
		public function can_create_entity():void
		{
			var entity:Entity = entities.create();
			assertTrue(entities.contains(entity));
		}
		
		[Test]
		public function can_remove_entity():void
		{
			var entity:Entity = entities.create();
			entities.remove(entity);
			assertFalse(entities.contains(entity));
		}
		
		[Test]
		public function can_create_named_entity():void
		{
			var entity:Entity = entities.create(BRIAN);
			assertTrue(entities.contains(entity));
		}
		
		[Test]
		public function can_reference_named_entity():void
		{
			var entity:Entity = entities.create(BRIAN);
			var referenced:Entity = entities.get(BRIAN);
			assertSame(entity, referenced);
		}
		
		[Test]
		public function cannot_duplicate_entity_names():void
		{
			entities.create(BRIAN);
			assertThrows(Error, duplicates_entity_name);
		}
		private function duplicates_entity_name():void
		{
			entities.create(BRIAN);
		}
		
		[Test]
		public function can_reuse_name_after_named_entity_is_deleted():void
		{
			var entity:Entity = entities.create(BRIAN);
			entities.remove(entity);
			var other:Entity = entities.create(BRIAN);
			assertNotSame(entity, other);
		}
		
		[Test]
		public function can_get_a_vector_of_all_entities():void
		{
			assertNotNull(entities.getAll());
		}
		
		[Test]
		public function getEntities_returns_all_generated_entities():void
		{
			var a:Entity = entities.create();
			var b:Entity = entities.create();

			var list:Vector.<Entity> = entities.getAll();
			assertSame(a, list[0]);
			assertSame(b, list[1]);
		}
		
		[Test]
		public function getEntities_does_not_expose_inner_list():void
		{
			var a:Entity = entities.create();
			
			var list:Vector.<Entity>;
			list = entities.getAll();
			list.shift();
			list = entities.getAll();
			
			assertSame(a, list[0]);
		}
		
		[Test]
		public function all_entities_can_be_removed_easily():void
		{
			var a:Entity = entities.create();
			var b:Entity = entities.create();
			
			entities.removeAll();
			
			assertFalse(entities.contains(a));
			assertFalse(entities.contains(b));
		}
		
	}
}
