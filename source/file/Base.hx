package file;
import sys.io.File;
import systools.Dialogs;

/**
 * ...
 * @author Ohmnivore
 */
class Base
{
	public static inline var INIT_DIR:String = "c:/";
	private static var filterProject:FILEFILTERS;
	
	public static function __init__():Void
	{
		filterProject = {
			count: 1
			, descriptions: ["Project file"]
			//, extensions: ["*.xml"]
			, extensions: []
			};
	}
	
	public static function newProject():String
	{
		var path:String = Dialogs.saveFile("New Project", "", INIT_DIR, filterProject);
		File.saveContent(path, "");
		return path;
	}
	
	public static function openProject():String
	{
		var paths:Array<String> = Dialogs.openFile("Open Project", "", filterProject);
		return paths[0];
	}
}