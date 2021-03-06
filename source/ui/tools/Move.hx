package ui.tools;
import flixel.FlxG;
import flixel.math.FlxPoint;

/**
 * ...
 * @author Ohmnivore
 */
class Move extends Tool
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
				if (s.alive)
				{
					didMove = true;
					s.x -= old.x - cur.x;
					s.y -= old.y - cur.y;
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