package alecmce.notice
{
	public interface SingularNotice
	{
		
		function addOnce(listener:Function):Boolean;
		
		function remove(listener:Function):Boolean;
		
	}
}
