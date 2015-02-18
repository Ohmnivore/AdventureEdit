package;

import flixel.addons.display.FlxZoomCamera;
import flixel.FlxCamera;
import flixel.util.FlxSave;
import save.Level;
import save.Project;
import ui.edit.EditImg;
import ui.tools.History;

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
	public static var copy:Array<EditImg> = [];
	public static var backCam:FlxZoomCamera;
	public static var history:History;
}