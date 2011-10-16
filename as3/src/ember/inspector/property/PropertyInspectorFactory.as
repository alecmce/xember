package ember.inspector.property
{
	import ember.inspector.property.inputs.BooleanTypeInput;
	import ember.inspector.property.inputs.IntTypeInput;
	import ember.inspector.property.inputs.NumberTypeInput;
	import ember.inspector.property.inputs.StringTypeInput;
	import ember.inspector.property.inputs.UintTypeInput;
	
	public class PropertyInspectorFactory
	{
		
		public function getInspector(label:String, klass:Class):PropertyInspector
		{
			var inspector:PropertyInspector = new PropertyInspector();
			inspector.label = label;
			
			switch (klass)
			{
				case String:
					inspector.input = new StringTypeInput();
					break;
				case Boolean:
					inspector.input = new BooleanTypeInput();
					break;
				case int:
					inspector.input = new IntTypeInput();
					break;
				case uint:
					inspector.input = new UintTypeInput();
					break;
				case Number:
					inspector.input = new NumberTypeInput();
					break;
			}
			
			return inspector;
		}
	}
}
