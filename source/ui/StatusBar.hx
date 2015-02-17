package ui;
import flixel.FlxG;
import flixel.text.FlxText;

/**
 * ...
 * @author Ohmnivore
 */
class StatusBar extends FlxText
{
	public var projectName:String;
	public var lvlName:String;
	public var projectSaved:Bool = true;
	public var lvlSaved:Bool = true;
	
	public function new(Y:Float) 
	{
		super(0, Y);
		AssetsGr.setTextStyle(this);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (projectName != null)
		{
			text = projectName;
			if (!projectSaved)
				text += "*";
		}
		
		if (lvlName != null)
		{
			text += " | ";
			text += lvlName;
			if (!lvlSaved)
				text += "*";
		}
		
		x = FlxG.width - width - 4;
	}
}