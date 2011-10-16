package ember.inspector.property.inputs
{
	
	public class IntTypeInput extends StringTypeInput
	{
		
		public function IntTypeInput()
		{
			super();
			_input.restrict = "\\-0-9";
		}
		
		override public function get value():*
		{
			return int(_input.text);
		}

		
	}
}
