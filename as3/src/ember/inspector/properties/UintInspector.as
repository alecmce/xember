package ember.inspector.properties
{

	public class UintInspector extends StringInspector
	{
		
		public function UintInspector()
		{
			super();
			_input.restrict = "0-9";
		}
		
	}
}
