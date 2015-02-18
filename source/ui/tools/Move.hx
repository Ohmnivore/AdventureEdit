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
	
	public function new()
	{
		super();
		old = new FlxPoint();
	}
	
	override public function update():Void 
	{
		if (FlxG.mouse.justPressed)
		{
			setOld();
		}
		
		if (FlxG.mouse.pressed)
		{
			var didMove:Bool = false;
			for (s in Reg.selected)
			{
				if (s.alive)
				{
					didMove = true;
					s.x -= old.x - FlxG.mouse.screenX;
					s.y -= old.y - FlxG.mouse.screenY;
				}
			}
			if (didMove)
			{
				Reg.level.saved = false;
				Reg.history.addHistory();
			}
			
			setOld();
		}
	}
	
	private function setOld():Void
	{
		old.set(FlxG.mouse.screenX, FlxG.mouse.screenY);
	}
}