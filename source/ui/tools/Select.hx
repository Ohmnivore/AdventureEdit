package ui.tools;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxSpriteUtil;
import states.Main;
import ui.edit.EditBase;
import ui.edit.EditEnt;
import ui.LayerGroup;
import ui.panels.LayerPanel;
import ui.tools.SelectList;

/**
 * ...
 * @author Ohmnivore
 */
class Select extends Tool
{
	public var list:SelectList;
	public var entList:EntityValueList;
	
	private var layers:LayerGroup;
	private var lPanel:LayerPanel;
	private var rect:SelectRect;
	private var m:Main;
	
	private var cur:FlxPoint;
	
	public function new(L:LayerGroup, LPanel:LayerPanel, M:Main) 
	{
		super();
		
		layers = L;
		lPanel = LPanel;
		rect = new SelectRect(0xff00D0FF);
		layers.cursorGroup.add(rect);
		rect.visible = false;
		cur = new FlxPoint();
		m = M;
		
		list = new SelectList(0, FlxG.height - 68, FlxG.width);
		m.back.add(list);
		list.visible = false;
		list.active = false;
	}
	
	override function show():Void 
	{
		rect.visible = true;
		
		list.visible = true;
		list.active = true;
		m.select.visible = false;
		m.select.active = false;
	}
	
	override function hide():Void 
	{
		rect.visible = false;
		
		list.visible = false;
		list.active = false;
		m.select.visible = true;
		m.select.active = true;
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
				var selected:EditBase = cast s;
				selected.selected = true;
				Reg.selected.push(selected);
			}
			
			list.setThumbs();
		}
		
		if (Reg.selected.length == 1)
		{
			if (Std.is(Reg.selected[0], EditEnt))
			{
				var e:EditEnt = cast Reg.selected[0];
				var should:Bool = false;
				if (entList == null)
				{
					should = true;
				}
				else
				{
					if (entList.ent != e)
					{
						hideEntList();
						should = true;
					}
				}
				if (should)
				{
					FlxG.log.add("new");
					entList = new EntityValueList(e, FlxG.width - 300, 200);
					setEntList();
					layers.cursorGroup.add(entList);
					setEntList();
				}
			}
			else
			{
				hideEntList();
			}
		}
		else
		{
			hideEntList();
		}
	}
	
	public function setEntList():Void
	{
		if (entList != null)
		{
			entList.cameras = [FlxG.camera];
			entList.scrollFactor.set();
		}
	}
	
	private function hideEntList():Void
	{
		if (entList != null)
		{
			FlxG.log.add("del");
			entList.kill();
			entList.destroy();
			entList = null;
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