package ember
{
	import asunit.asserts.assertFalse;
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
			var entity:ConcreteEntity = entities.create();
			assertTrue(entities.contains(entity));
		}
		
		[Test]
		public function can_remove_entity():void
		{
			var entity:ConcreteEntity = entities.create();
			entities.remove(entity);
			assertFalse(entities.contains(entity));
		}
		
		[Test]
		public function can_create_named_entity():void
		{
			var entity:ConcreteEntity = entities.create(BRIAN);
			assertTrue(entities.contains(entity));
		}
		
		[Test]
		public function can_reference_named_entity():void
		{
			var entity:ConcreteEntity = entities.create(BRIAN);
			var referenced:ConcreteEntity = entities.get(BRIAN);
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
			var entity:ConcreteEntity = entities.create(BRIAN);
			entities.remove(entity);
			var other:ConcreteEntity = entities.create(BRIAN);
			assertNotSame(entity, other);
		}
	}
}
