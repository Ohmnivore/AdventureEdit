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
class Tool
{
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
	
	public function new() 
	{
		
	}
	
	private function show():Void
	{
		
	}
	
	private function hide():Void
	{
		
	}
	
	public function update():Void
	{
		
	}
}