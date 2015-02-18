package ui.tools;
import file.ImageHandler;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import ui.edit.EditImg;
import ui.LayerGroup;
import ui.panels.LayerPanel;
import ui.select.List;

/**
 * ...
 * @author Ohmnivore
 */
class Add extends Tool
{
	private var lPanel :LayerPanel;
	private var l:LayerGroup;
	private var s:List;
	
	private var stamp:FlxSprite;
	private var lastStamp:String;
	private var lastLayer:String;
	
	private var cur:FlxPoint;
	
	public function new(L:LayerPanel, Layers:LayerGroup, Select:List) 
	{
		super();
		lPanel = L;
		l = Layers;
		s = Select;
		cur = new FlxPoint();
	}
	
	override private function show():Void
	{
		
	}
	
	override private function hide():Void
	{
		clearStamp();
	}
	
	override public function update():Void
	{
		FlxG.mouse.getWorldPosition(Reg.backCam, cur);
		if (stamp != null)
		{
			stamp.x = cur.x;
			stamp.y = cur.y;
			
			if (FlxG.mouse.justReleased)
			{
				if (lPanel.currentLayer != null && s.currentThumb != null)
				{
					l.get(lPanel.currentLayer).add(new EditImg(cur.x, cur.y,
						s.currentThumb.path));
					Reg.level.saved = false;
					Reg.history.addHistory();
				}
			}
		}
		
		if (s.currentThumb != null)
		{
			if (s.currentThumb.path != lastStamp || lPanel.currentLayer != lastLayer)
				setStamp();
		}
	}
	
	private function setStamp():Void
	{
		clearStamp();
		
		if (s.currentThumb != null)
		{
			lastStamp = s.currentThumb.path;
			lastLayer = lPanel.currentLayer;
			
			stamp = new FlxSprite();
			new ImageHandler(s.currentThumb.path, stamp);
			stamp.alpha = 0.8;
			
			l.cursorGroup.add(stamp);
		}
		else
		{
			clearStamp();
		}
	}
	
	private function clearStamp():Void
	{
		if (stamp != null)
		{
			l.cursorGroup.remove(stamp, true);
			
			stamp.kill();
			stamp.destroy();
			
			lastStamp = null;
			lastLayer = null;
		}
	}
}