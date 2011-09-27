package ember
{
	import org.osflash.signals.Signal;

	import flash.utils.Dictionary;
	
	final public class Nodes
	{
		private var _node:Class;
		private var _config:NodesConfig;
		
		private var _nodeRemoved:Signal;
		private var _nodeAdded:Signal;
		
		private var _entityMap:Dictionary;
		
		private var _head:*;
		private var _tail:*;
		
		public function Nodes(node:Class, config:NodesConfig)
		{
			_node = node;
			_config = config;
			
			_entityMap = new Dictionary();
		}
		
		public function get head():*
		{
			return _head;
		}

		public function get tail():*
		{
			return _tail;
		}
		
		public function get config():NodesConfig
		{
			return _config;
		}
		
		public function add(entity:Entity):void
		{
			if (_entityMap[entity] != null)
				return;
			
			var node:* = _config.generateNode(entity);
			addToLinkedList(node);
			
			_entityMap[entity] = node;
			
			if (_nodeAdded)
				_nodeAdded.dispatch(node);
		}
		
		public function remove(entity:Entity):void
		{
			if (_entityMap[entity] == null)
				return;

			var node:* = _entityMap[entity];
			removeFromLinkedList(node);
			
			delete _entityMap[entity];
			
			if (_nodeRemoved)
				_nodeRemoved.dispatch(node);
		}
		
		private function addToLinkedList(node:*):void
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
		
		private function removeFromLinkedList(node:*):void
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
			return _nodeAdded ||= new Signal();
		}

		public function get nodeRemoved():Signal
		{
			return _nodeRemoved ||= new Signal();
		}
		
	}
}
