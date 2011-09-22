package alecmce.time
{
	import alecmce.notice.Notice;
	
	public interface Time
	{
		
		function get now():uint;
		
		function get tick():Notice;
		
	}
}
