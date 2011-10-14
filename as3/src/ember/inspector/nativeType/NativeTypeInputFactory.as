package ember.inspector.nativeType
{
	public class NativeTypeInputFactory
	{
		public function getInputFor(type:*):NativeTypeInput
		{
			var input:NativeTypeInput;
			
			if (type is String)
				input = new StringTypeInput();
			else if (type is Boolean)
				input = new BooleanTypeInput();
			else if (type is int)
				input = new IntTypeInput();
			
			return input;
		}
	}
}
