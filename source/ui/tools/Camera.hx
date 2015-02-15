package ui.tools;
import flixel.FlxG;
import flixel.math.FlxPoint;

/**
 * ...
 * @author Ohmnivore
 */
class Camera
{
	private var old:FlxPoint;
	
	public function new()
	{
		old = new FlxPoint();
	}
	
	public function update()
	{
		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.mouse.visible = false;
			
			setOld();
		}
		if (FlxG.keys.pressed.SPACE)
		{
			FlxG.camera.scroll.x += old.x - FlxG.mouse.screenX;
			FlxG.camera.scroll.y += old.y - FlxG.mouse.screenY;
			
			setOld();
		}
		if (FlxG.keys.justReleased.SPACE)
			FlxG.mouse.visible = true;
	}
	
	private function setOld():Void
	{
		old.set(FlxG.mouse.screenX, FlxG.mouse.screenY);
	}
}