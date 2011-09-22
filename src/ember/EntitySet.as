package ember
{
	import org.osflash.signals.Signal;
	
	public interface EntitySet
	{
		
		function get head():Node;
		function get tail():Node;
		
		function get nodeAdded():Signal;
		function get nodeRemoved():Signal;
		
	}
}
