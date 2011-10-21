package ember.inspector
{
	import avmplus.getQualifiedClassName;
	import ember.core.Entity;
	
	public class EntityInspectorFactory
	{
		private var _components:ComponentInspectorFactory;

		public function EntityInspectorFactory(components:ComponentInspectorFactory)
		{
			_components = components;
		}

		public function getInspector(entity:Entity):EntityInspector
		{
			var inspector:EntityInspector = new EntityInspector();

			var classes:Vector.<Class> = entity.getClasses();
			for each (var klass:Class in classes)
			{
				var name:String = getQualifiedClassName(klass);
				var component:ComponentInspector = _components.getInspector(entity.getComponent(klass));
				inspector.addComponent(name, component);
			}
			
			return inspector;
		}

	}
}
