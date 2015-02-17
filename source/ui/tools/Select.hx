package ui.tools;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxSpriteUtil;
import ui.edit.EditImg;
import ui.LayerGroup;
import ui.panels.LayerPanel;

/**
 * ...
 * @author Ohmnivore
 */
class Select extends Tool
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
		rect = new SelectRect(0xff00D0FF);
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
			layers.setAllSelection(false);
			Reg.selected = [];
			for (s in getSelected())
			{
				var selected:EditImg = cast s;
				selected.selected = true;
				Reg.selected.push(selected);
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