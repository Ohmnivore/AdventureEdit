package ui.tools;
import flixel.FlxG;
import flixel.math.FlxPoint;
import ui.edit.EditEnt;

/**
 * ...
 * @author Ohmnivore
 */
class Resize extends Tool
{
	private var old:FlxPoint;
	private var cur:FlxPoint;
	
	public function new() 
	{
		super();
		old = new FlxPoint();
		cur = new FlxPoint();
	}
	
	override public function update():Void 
	{
		FlxG.mouse.getScreenPosition(Reg.backCam, cur);
		if (FlxG.mouse.justPressed)
		{
			setOld();
		}
		
		if (FlxG.mouse.justReleased)
		{
			Reg.level.saved = false;
			Reg.history.addHistory();
		}
		
		if (FlxG.mouse.pressed)
		{
			var didMove:Bool = false;
			for (s in Reg.selected)
			{
				if (Std.is(s, EditEnt) && s.alive)
				{
					var e:EditEnt = cast s;
					didMove = true;
					//e.startResize();
					//s.scale.x -= (old.x - FlxG.mouse.screenX) / 50;
					//s.scale.y -= (old.y - FlxG.mouse.screenY) / 50;
					//s.updateHitbox();
					s.width -= old.x - cur.x;
					s.height -= old.y - cur.y;
				}
			}
			if (didMove)
			{
				//Reg.level.saved = false;
				//Reg.history.addHistory();
			}
			
			setOld();
		}
	}
	
	private function setOld():Void
	{
		old.set(cur.x, cur.y);
	}
}