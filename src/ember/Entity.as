package ember
{
	public interface Entity
	{
		
		function addComponent(component:Object, componentClass:Class = null):void;
		
		function getComponent(component:Class):Object;

		function removeComponent(component:Class):void;
		
		function hasComponent(component:Class):Boolean;
		
	}
}
