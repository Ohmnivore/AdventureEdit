package ui.tools;
import flixel.FlxG;

/**
 * ...
 * @author Ohmnivore
 */
class Zoom
{
	private static inline var ZOOM_MAX:Float = 4.0;
	private static inline var ZOOM_MIN:Float = 0.25;
	private static inline var ZOOM_MULT:Float = 2.0;
	
	private var curZoom:Float = 1.0;
	
	public function new() 
	{
		
	}
	
	public function zoomIn():Void
	{
		curZoom *= ZOOM_MULT;
		if (curZoom > ZOOM_MAX)
			curZoom = ZOOM_MAX;
		
		applyZoom();
	}
	
	public function zoomOut():Void
	{
		curZoom /= ZOOM_MULT;
		if (curZoom < ZOOM_MIN)
			curZoom = ZOOM_MIN;
		
		Reg.backCam.width = cast FlxG.width / curZoom;
		Reg.backCam.height = cast FlxG.height / curZoom;
		Reg.backCam.x = -Reg.backCam.width / 4.0;
		Reg.backCam.y = -Reg.backCam.height / 4.0;
		
		applyZoom();
	}
	
	private function applyZoom():Void
	{
		Reg.backCam.zoom = curZoom;
	}
}