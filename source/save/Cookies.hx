package save;
import flixel.FlxG;
import sys.FileSystem;
import openfl.utils.SystemPath;

/**
 * ...
 * @author Ohmnivore
 */
class Cookies
{
	public static var SAVE_NAME:String = "AdventureEdit";
	
	private static function open():Void
	{
		FlxG.save.bind(SAVE_NAME);
	}
	
	private static function close():Void
	{
		FlxG.save.close();
	}
	
	public static function get(Name:String):String
	{
		open();
		var ret:String = cast Reflect.field(FlxG.save.data, Name);
		close();
		
		return ret;
	}
	
	public static function set(Name:String, Value:String):Void
	{
		open();
		Reflect.setField(FlxG.save.data, Name, Value);
		close();
	}
	
	public static function isValidPath(P:String):Bool
	{
		if (P == null)
			return false;
		else if (!FileSystem.exists(P))
			return false;
		
		return true;
	}
	
	public static function desktopPath():String
	{
		return SystemPath.desktopDirectory;
	}
}