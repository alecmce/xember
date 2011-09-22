package ember
{
	public class NodeIterator
	{
		
		private var _list:Vector.<Function>;
		
		public function NodeIterator(list:Vector.<Node>, fnName:String)
		{
			var i:uint = list.length;
			_list = new Vector.<Function>(i, true);
			while (i--)
				_list[i] = list[i][fnName];
		}

		
	}
}
