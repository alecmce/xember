package ember
{
	public interface Entity
	{
		
		function addAttribute(attribute:Object, attributeClass:Class = null):void;
		
		function getAttribute(attribute:Class):Object;

		function removeAttribute(attribute:Class):void;
		
		function hasAttribute(attribute:Class):Boolean;
		
	}
}
