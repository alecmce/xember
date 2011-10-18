package ember.inspector.properties
{

	public class NumberInspector extends StringInspector
	{

		public function NumberInspector()
		{
			super();
			_input.restrict = "\\.\\-0-9";
		}
		
	}
}
