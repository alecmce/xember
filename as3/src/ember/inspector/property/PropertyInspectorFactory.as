package ember.inspector.property
{
	import ember.inspector.property.inputs.BooleanTypeInput;
	import ember.inspector.property.inputs.IntTypeInput;
	import ember.inspector.property.inputs.NumberTypeInput;
	import ember.inspector.property.inputs.StringTypeInput;
	import ember.inspector.property.inputs.UintTypeInput;
	
	public class PropertyInspectorFactory
	{
		public function getInputFor(type:String):PropertyInspector
		{
			var inspector:PropertyInspector = new PropertyInspector();
			
			if (type == "String")
				inspector.input = new StringTypeInput();
			else if (type == "Boolean")
				inspector.input = new BooleanTypeInput();
			else if (type == "int")
				inspector.input = new IntTypeInput();
			else if (type == "uint")
				inspector.input = new UintTypeInput();
			else if (type == "Number")
				inspector.input = new NumberTypeInput();
			
			return inspector;
		}
	}
}
