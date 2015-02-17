package ui.tools;
import flixel.math.FlxPoint;
import ui.panels.LayerPanel;
import flixel.FlxSprite;
import flixel.FlxG;
import ui.edit.EditImg;

/**
 * ...
 * @author Ohmnivore
 */
class Remove extends Tool
{
	private var layers:LayerGroup;
	private var lPanel:LayerPanel;
	private var rect:SelectRect;
	
	private var cur:FlxPoint;
	
	public function new(L:LayerGroup, LPanel:LayerPanel) 
	{
		super();
		
		layers = L;
		lPanel = LPanel;
		rect = new SelectRect(0xffff0000);
		layers.cursorGroup.add(rect);
		rect.visible = false;
		cur = new FlxPoint();
	}
	
	override function show():Void 
	{
		rect.visible = true;
	}
	
	override function hide():Void 
	{
		rect.visible = false;
	}
	
	override public function update():Void 
	{
		FlxG.mouse.getWorldPosition(Reg.backCam, cur);
		if (FlxG.mouse.justPressed)
		{
			rect.visible = true;
			rect.startPoint.set(cur.x, cur.y);
		}
		if (FlxG.mouse.pressed)
		{
			rect.endPoint.set(cur.x, cur.y);
		}
		if (FlxG.mouse.justReleased)
		{
			rect.visible = false;
			for (s in getSelected())
			{
				var selected:EditImg = cast s;
				if (selected.selected)
				{
					Reg.selected.remove(selected);
				}
				selected.kill();
				selected.destroy();
			}
		}
	}
	
	private function getSelected():Array<FlxSprite>
	{
		var ret:Array<FlxSprite> = [];
		
		if (lPanel.currentLayer != null)
		{
			for (s in layers.get(lPanel.currentLayer).members)
			{
				if (rect.overlaps(s))
					ret.push(s);
			}
		}
		
		return ret;
	}
}