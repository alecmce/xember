package ember.core
{
	import flash.utils.Dictionary;
	
	final internal class NodesComponentMap
	{
		private var _map:Dictionary;

		public function NodesComponentMap()
		{
			_map = new Dictionary();
		}

		public function add(list:NodeConfigComponentsList, nodes:Nodes):void
		{
			var components:Vector.<Class> = list.components;
			for each (var component:Class in components)
				(_map[component] ||= new Vector.<Nodes>()).push(nodes);
		}

		public function getNodesFor(component:Class):Vector.<Nodes>
		{
			return _map[component] ||= new Vector.<Nodes>();
		}
		
	}
}
