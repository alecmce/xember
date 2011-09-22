package ember
{
	import org.osflash.signals.Signal;

	import flash.utils.Dictionary;
	
	final internal class ConcreteEntitySet implements EntitySet
	{
		private var _node:Class;
		private var _configuration:EntitySetConfiguration;
		
		private var _nodeRemoved:Signal;
		private var _nodeAdded:Signal;
		
		private var _entityMap:Dictionary;
		
		private var _head:Node;
		private var _tail:Node;
		
		public function ConcreteEntitySet(node:Class, configuration:EntitySetConfiguration)
		{
			_node = node;
			_configuration = configuration;
			
			_entityMap = new Dictionary();
		}
		
		public function get head():Node
		{
			return _head;
		}

		public function get tail():Node
		{
			return _tail;
		}
		
		public function get configuration():EntitySetConfiguration
		{
			return _configuration;
		}
		
		public function add(entity:ConcreteEntity):void
		{
			if (_entityMap[entity] != null)
				return;
			
			var node:Node = generateNode(entity);
			addToLinkedList(node);
			
			_entityMap[entity] = node;
			
			if (_nodeAdded)
				_nodeAdded.dispatch(node);
		}
		
		public function remove(entity:ConcreteEntity):void
		{
			if (_entityMap[entity] == null)
				return;

			var node:Node = _entityMap[entity];
			removeFromLinkedList(node);
			
			delete _entityMap[entity];
			
			if (_nodeRemoved)
				_nodeRemoved.dispatch(node);
		}
		
		private function generateNode(entity:ConcreteEntity):Node
		{
			var node:Node = new _node();
			_configuration.configureNode(node, entity);
			return node;
		}
		
		private function addToLinkedList(node:Node):void
		{
			if (!_head)
			{
				_head = _tail = node;
				return;
			}
			
			node.prev = _tail;
			_tail.next = node;
			_tail = node;
		}
		
		private function removeFromLinkedList(node:Node):void
		{
			if (_head == node)
				_head = _head.next;
			
			if (_tail == node)
				_tail = _tail.prev;
			
			if (node.prev)
				node.prev.next = node.next;
			
			if (node.next)
				node.next.prev = node.prev;
				
			node.prev = null;
			node.next = null;
		}

		public function get nodeAdded():Signal
		{
			return _nodeAdded ||= new Signal(Node);
		}

		public function get nodeRemoved():Signal
		{
			return _nodeRemoved ||= new Signal(Node);
		}
		
	}
}
