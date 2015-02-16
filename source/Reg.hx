package;

import flixel.FlxCamera;
import flixel.util.FlxSave;
import save.Level;
import save.Project;
import ui.edit.EditImg;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static var project:Project;
	public static var level:Level;
	public static var selected:Array<EditImg> = [];
	public static var backCam:FlxCamera;
}