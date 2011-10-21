package ember.inspector
{
	import ember.core.Ember;
	import ember.core.Entity;

	import flash.utils.Dictionary;
	
	public class EntityInspectorFactory
	{
		private var _ember:Ember;
		private var _components:ComponentInspectorFactory;
		
		private var _inspectorMap:Dictionary;

		public function EntityInspectorFactory(ember:Ember, components:ComponentInspectorFactory)
		{
			_ember = ember;
			_ember.entityComponentAdded.add(onComponentAdded);
			_ember.entityComponentRemoved.add(onComponentRemoved);
			_ember.entityRemoved.add(onEntityRemoved);
			
			_components = components;
			_inspectorMap = new Dictionary();
		}
		
		public function getInspector(entity:Entity):EntityInspector
		{
			return _inspectorMap[entity] ||= createInspector(entity);
		}

		private function createInspector(entity:Entity):EntityInspector
		{
			var inspector:EntityInspector = new EntityInspector();
			
			var classes:Vector.<Class> = entity.getClasses();
			for each (var klass:Class in classes)
				addComponent(inspector, klass, entity.getComponent(klass));
			
			return inspector;
		}

		private function addComponent(entity:EntityInspector, klass:Class, component:Object):void
		{
			var inspector:ComponentInspector = _components.getInspector(component);
			entity.addComponent(klass, inspector);
		}
		
		private function onComponentAdded(entity:Entity, component:Class):void
		{
			var inspector:EntityInspector = _inspectorMap[entity];
			if (!inspector)
				return;
			
			addComponent(inspector, component, entity.getComponent(component));
		}

		private function onComponentRemoved(entity:Entity, component:Class):void
		{
			var inspector:EntityInspector = _inspectorMap[entity];
			if (!inspector)
				return;
			
			inspector.removeComponent(component);
		}
		
		private function onEntityRemoved(entity:Entity):void
		{
			var inspector:EntityInspector = _inspectorMap[entity];
			if (!inspector)
				return;
			
			inspector.dispose();
			delete _inspectorMap[entity];
		}
	}
}
