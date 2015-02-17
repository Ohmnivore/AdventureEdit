package ui.tools;
import flixel.FlxSprite;
import flixel.addons.ui.FlxClickArea;
import flixel.FlxG;

/**
 * ...
 * @author Ohmnivore
 */
class SelectThumbnail extends FlxSprite
{
	public var callback:SelectThumbnail->Void;
	public var toCopy:FlxSprite;
	private var area:FlxClickArea;
	
	public function new(X:Float, Y:Float, ToCopy:FlxSprite, Callback:SelectThumbnail->Void = null)
	{
		callback = Callback;
		toCopy = ToCopy;
		super(X, Y);
		loadGraphicFromSprite(ToCopy);
		
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
		if (callback != null)
			callback(this);
	}
}