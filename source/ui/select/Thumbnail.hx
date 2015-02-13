package ui.select;
import flixel.addons.ui.FlxClickArea;
import flixel.addons.ui.FlxUISprite;
import flixel.FlxG;

/**
 * ...
 * @author Ohmnivore
 */
class Thumbnail extends FlxUISprite
{
	public var callback:Thumbnail->Void;
	private var _toggled:Bool = false;
	
	public var toggled(get, set):Bool;
	public function get_toggled():Bool
	{
		return _toggled;
	}
	public function set_toggled(V:Bool):Bool
	{
		_toggled = V;
		
		if (_toggled)
			color = 0xff5555;
		else
			color = 0xffffff;
		
		return _toggled;
	}
	
	private var area:FlxClickArea;
	
	public function new(X:Float, Y:Float, Callback:Thumbnail->Void = null) 
	{
		callback = Callback;
		super(X, Y);
		
		area = new FlxClickArea(X, Y, width, height, call);
		FlxG.state.add(area);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		area.x = x;
		area.y = y;
		area.width = width;
		area.height = height;
	}
	
	private function call():Void
	{
		toggled = !toggled;
		
		if (callback != null)
			callback(this);
	}
}