package ember.core
{
	final internal class NodeConfigComponentsList
	{
		
		private var _names:Vector.<String>;
		private var _components:Vector.<Class>;
		private var _count:uint;
		
		public function NodeConfigComponentsList()
		{
			_names = new Vector.<String>();
			_components = new Vector.<Class>();
			_count = 0;
		}
		
		public function add(name:String, component:Class):void
		{
			_names.push(name);
			_components.push(component);
			++_count;
		}
		
		public function contains(component:Class):Boolean
		{
			return _components.indexOf(component) != -1;
		}

		public function areComponentsIn(entity:Entity):Boolean
		{
			var i:int = _components.length;
			while (i--)
			{
				if (!entity.hasComponent(_components[i]))
					return false;
			}
			
			return true;
		}

		public function populateNode(node:*, entity:Entity):void
		{
			for (var i:int = 0; i < _count; i++)
			{
				var nodeName:String = _names[i];
				var component:Class = _components[i];
				var value:Object = entity.getComponent(component);
				node[nodeName] = value;
			}
		}
		
	}
}
