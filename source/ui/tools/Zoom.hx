package ui.tools;
import flixel.FlxG;
import states.Main;

/**
 * ...
 * @author Ohmnivore
 */
class Zoom
{
	private static inline var ZOOM_MAX:Float = 2.0;
	private static inline var ZOOM_MIN:Float = 0.5;
	private static inline var ZOOM_MULT:Float = 2.0;
	
	private var curZoom:Float = 1.0;
	private var m:Main;
	
	public function new(M:Main) 
	{
		m = M;
	}
	
	public function zoomIn():Void
	{
		curZoom *= ZOOM_MULT;
		if (curZoom > ZOOM_MAX)
			curZoom = ZOOM_MAX;
		
		Reg.backCam.width = cast FlxG.width;
		Reg.backCam.height = cast FlxG.height;
		
		applyZoom();
	}
	
	public function zoomOut():Void
	{
		curZoom /= ZOOM_MULT;
		if (curZoom < ZOOM_MIN)
			curZoom = ZOOM_MIN;
		
		Reg.backCam.width = cast FlxG.width / curZoom;
		Reg.backCam.height = cast FlxG.height / curZoom;
		Reg.backCam.x = -Reg.backCam.width / 2.0;
		Reg.backCam.y = -Reg.backCam.height / 2.0;
		
		applyZoom();
	}
	
	private function applyZoom():Void
	{
		Reg.backCam.targetZoom = curZoom;
		m.centerView();
	}
}