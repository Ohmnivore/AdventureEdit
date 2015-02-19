package save;
import haxe.io.Path;

/**
 * ...
 * @author Ohmnivore
 */
class Relative
{
	public static function getRelFrom(Original:String, From:String):String 
	{
		Original = Path.normalize(Original);
		From = Path.normalize(From);
		trace(Original, From);
		
		var ret:String = "";
		var common:String = getCommon(Original, From);
		ret = From.substr(common.length);
		
		var ups:Int = countCharOccurences(ret, "/") + 1;
		ret = Original.substr(common.length);
		var i:Int = 0;
		while (i <= ups)
		{
			ret = "../" + ret;
			i++;
		}
		
		return ret;
	}
	
	private static function countCharOccurences(S:String, C:String):Int
	{
		var ret:Int = 0;
		var i:Int = 0;
		while (i < S.length)
		{
			if (S.charAt(i) == C)
				ret++;
			
			i++;
		}
		return ret;
	}
	
	private static function getCommon(P1:String, P2:String):String
	{
		var str:String = "";
		var max:Int = (P1.length < P2.length)? P1.length : P2.length;
		var i:Int = 0;
		while (i < max)
		{
			var c1:String = P1.charAt(i);
			var c2:String = P2.charAt(i);
			if (c1 == c2)
				str += c1;
			else
				break;
			
			i++;
		}
		return str;
	}
}