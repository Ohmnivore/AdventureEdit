package ui.tools;
import file.ImageHandler;
import flixel.FlxG;
import flixel.FlxSprite;
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
			
			if (FlxG.mouse.justPressed)
			{
				
			}
		}
		
		if (s.currentThumb != null)
		{
			if (s.currentThumb.path != lastStamp)
				setStamp();
		}
	}
	
	private function setStamp():Void
	{
		clearStamp();
		
		if (s.currentThumb != null)
		{
			lastStamp = s.currentThumb.path;
			
			stamp = new FlxSprite();
			new ImageHandler(s.currentThumb.path, stamp);
			stamp.alpha = 0.8;
			
			if (lPanel.currentLayer != null)
				l.get(lPanel.currentLayer).add(stamp);
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
			stamp.kill();
			stamp.destroy();
		}
	}
}