package ui.tools;
import file.ImageHandler;
import flixel.FlxG;
import flixel.FlxSprite;
import ui.edit.EditImg;
import ui.LayerGroup;
import ui.panels.LayerPanel;
import ui.select.List;

/**
 * ...
 * @author Ohmnivore
 */
class Add
{
	private var lPanel :LayerPanel;
	private var l:LayerGroup;
	private var s:List;
	
	private var _opened:Bool = false;
	public var opened(get, set):Bool;
	public function get_opened():Bool
	{
		return _opened;
	}
	public function set_opened(V:Bool):Bool
	{
		if (!_opened && V)
			show();
		if (_opened && !V)
			hide();
		
		_opened = V;
		
		return _opened;
	}
	
	private var stamp:FlxSprite;
	private var lastStamp:String;
	private var lastLayer:String;
	
	public function new(L:LayerPanel, Layers:LayerGroup, Select:List) 
	{
		lPanel = L;
		l = Layers;
		s = Select;
	}
	
	private function show():Void
	{
		
	}
	
	private function hide():Void
	{
		clearStamp();
	}
	
	public function update():Void
	{
		if (stamp != null)
		{
			stamp.x = FlxG.mouse.x;
			stamp.y = FlxG.mouse.y;
			
			if (FlxG.mouse.justReleased)
			{
				if (lPanel.currentLayer != null && s.currentThumb != null)
				{
					l.get(lPanel.currentLayer).add(new EditImg(FlxG.mouse.x, FlxG.mouse.y,
						s.currentThumb.path));
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
		}
	}
}