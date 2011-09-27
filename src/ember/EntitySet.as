package ember
{
	import org.osflash.signals.Signal;
	
	public interface EntitySet
	{
		
		function get head():*;
		function get tail():*;
		
		function get nodeAdded():Signal;
		function get nodeRemoved():Signal;
		
	}
}
