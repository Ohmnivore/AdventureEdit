package ui.tools;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.math.FlxPoint;

/**
 * ...
 * @author Ohmnivore
 */
class Camera
{
	private var old:FlxPoint;
	private var cam:FlxCamera;
	
	public function new()
	{
		old = new FlxPoint();
		cam = Reg.backCam;
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
			cam.scroll.x += old.x - FlxG.mouse.screenX;
			cam.scroll.y += old.y - FlxG.mouse.screenY;
			
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