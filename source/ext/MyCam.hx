package ext;
import flixel.addons.display.FlxZoomCamera;

/**
 * ...
 * @author Ohmnivore
 */
class MyCam extends FlxZoomCamera
{
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (targetZoom == 0.5)
		{
			x = -width / 4.0;
			y = -height / 4.0;
		}
	}
}