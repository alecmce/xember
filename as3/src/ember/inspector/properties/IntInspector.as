package ember.inspector.properties
{
	
	public class IntInspector extends StringInspector
	{
		
		public function IntInspector()
		{
			super();
			_input.restrict = "\\-0-9";
		}
		
	}
}
