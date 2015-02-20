package ui.tools;
import flixel.FlxG;
import flixel.math.FlxPoint;
import states.Main;
import ui.edit.EditEnt;
import ui.panels.LayerPanel;

/**
 * ...
 * @author Ohmnivore
 */
class AddEntity extends Tool
{
	public var list:EntityList;
	
	private var layers:LayerGroup;
	private var lPanel:LayerPanel;
	private var m:Main;
	
	private var curName:String;
	private var stamp:EditEnt;
	
	private var cur:FlxPoint;
	
	public function new(L:LayerGroup, LPanel:LayerPanel, M:Main) 
	{
		super();
		layers = L;
		lPanel = LPanel;
		m = M;
		cur = new FlxPoint();
		
		list = new EntityList(0, FlxG.height - 68, FlxG.width);
		m.back.add(list);
		list.visible = false;
		list.active = false;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Reg.curEnt != null)
		{
			if (curName != Reg.curEnt.name)
			{
				setStamp();
				curName = Reg.curEnt.name;
			}
		}
		
		FlxG.mouse.getWorldPosition(Reg.backCam, cur);
		if (stamp != null)
		{
			stamp.x = cur.x;
			stamp.y = cur.y;
			
			if (FlxG.mouse.justReleased)
			{
				if (lPanel.currentLayer != null && Reg.curEnt != null)
				{
					layers.get(lPanel.currentLayer).add(new EditEnt(Reg.curEnt, cur.x, cur.y));
					Reg.level.saved = false;
					Reg.history.addHistory();
				}
			}
		}
	}
	
	private function setStamp():Void
	{
		clearStamp();
		stamp = new EditEnt(Reg.curEnt);
		stamp.alpha = 0.8;
		layers.cursorGroup.add(stamp);
	}
	
	private function clearStamp():Void
	{
		if (stamp != null)
		{
			layers.cursorGroup.remove(stamp, true);
			stamp.kill();
			stamp.destroy();
			curName = null;
		}
	}
	
	override function show():Void 
	{
		if (stamp != null)
			stamp.visible = true;
		list.visible = true;
		list.active = true;
		m.select.visible = false;
		m.select.active = false;
	}
	
	override function hide():Void 
	{
		if (stamp != null)
			stamp.visible = false;
		list.visible = false;
		list.active = false;
		m.select.visible = true;
		m.select.active = true;
	}
}