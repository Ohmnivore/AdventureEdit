package ui.tools;
import flixel.FlxG;
import flixel.math.FlxPoint;
import ui.edit.EditImg;
import ui.LayerGroup;
import ui.panels.LayerPanel;

/**
 * ...
 * @author Ohmnivore
 */
class Clip
{
	public var layers:LayerGroup;
	public var lPanel:LayerPanel;
	
	public function new(L:LayerGroup, LPanel:LayerPanel)
	{
		layers = L;
		lPanel = LPanel;
	}
	
	public function copy():Void
	{
		Reg.copy = [];
		for (s in Reg.selected)
		{
			Reg.copy.push(s);
		}
	}
	
	public function paste():Void
	{
		var addPoint:FlxPoint = FlxG.mouse.getWorldPosition(Reg.backCam);
		
		for (s in Reg.copy)
		{
			if (s != null)
			{
				if (s.alive)
				{
					var copy:EditImg = s.getCopy();
					copy.x = addPoint.x;
					copy.y = addPoint.y;
					
					addPoint.x += copy.width + 4;
					
					if (lPanel.currentLayer != null)
					{
						layers.get(lPanel.currentLayer).add(copy);
					}
				}
			}
		}
	}
}