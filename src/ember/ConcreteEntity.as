package ember
{
	import org.osflash.signals.Signal;

	import flash.utils.Dictionary;
	
	final internal class ConcreteEntity implements Entity
	{
		private var _attributes:Dictionary;
		private var _attributeAdded:Signal;
		private var _attributeRemoved:Signal;
		
		public function ConcreteEntity(attributeAdded:Signal, attributeRemoved:Signal)
		{
			_attributes = new Dictionary();
			_attributeAdded = attributeAdded;
			_attributeRemoved = attributeRemoved;
		}
		
		public function addAttribute(attribute:Object, attributeClass:Class = null):void
		{
			attributeClass ||= attribute["constructor"];
			_attributes[attributeClass] = attribute;
			_attributeAdded.dispatch(this, attributeClass);
		}

		public function getAttribute(attribute:Class):Object
		{
			return _attributes[attribute];
		}

		public function removeAttribute(attribute:Class):void
		{
			if (_attributes[attribute] == null)
				return;
			
			delete _attributes[attribute];
			_attributeRemoved.dispatch(this, attribute);
		}

		public function hasAttribute(attribute:Class):Boolean
		{
			return _attributes[attribute] != null;
		}

		public function get attributeRemoved():Signal
		{
			return _attributeRemoved;
		}
		
	}
}
