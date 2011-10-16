package ember.inspector.property.inputs
{

	public class NumberTypeInput extends StringTypeInput
	{

		public function NumberTypeInput()
		{
			super();
			_input.restrict = "\\.\\-0-9";
		}
		
		override public function get value():*
		{
			return int(_input.text);
		}

		
	}
}
