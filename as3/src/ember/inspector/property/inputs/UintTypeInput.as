package ember.inspector.property.inputs
{

	public class UintTypeInput extends StringTypeInput
	{
		
		public function UintTypeInput()
		{
			super();
			_input.restrict = "0-9";
		}
		
		override public function get value():*
		{
			return int(_input.text);
		}

		
	}
}
