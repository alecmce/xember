package ember.core
{

	import org.hamcrest.Matcher;
	
	public function matchesVector(... args):Matcher
	{
		return new UintVectorMatcher(Vector.<uint>(args));
	}

}

import org.hamcrest.Description;
import org.hamcrest.Matcher;

class UintVectorMatcher implements Matcher
{
	private var _expected:Vector.<uint>;
	private var _length:uint;
	
	public function UintVectorMatcher(expected:Vector.<uint>)
	{
		_expected = expected;
		_length = _expected.length;
	}
	
	public function describeTo(description:Description):void
	{
		description.appendText("expected " + _expected);
	}

	public function describeMismatch(item:Object, mismatch:Description):void
	{
		var actual:Vector.<uint> = item as Vector.<uint>;
		if (!actual)
		{
			mismatch.appendText("value is not a Vector.<uint>");
			return;
		}
		
		if (_length != actual.length)
		{
			mismatch.appendText(item + ".length != " + _length.toString());
			return;
		}
		
		mismatch.appendText("was " + item);
	}

	public function matches(item:Object):Boolean
	{
		var actual:Vector.<uint> = item as Vector.<uint>;
		if (!actual)
			return false;
		
		if (_length != actual.length)
			return false;
		
		var i:int = _length;
		while (i--)
		{
			if (_expected[i] != actual[i])
				return false;
		}
		
		return true;
	}
	
}