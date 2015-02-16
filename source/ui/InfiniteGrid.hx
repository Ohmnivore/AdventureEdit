package ui;
import flixel.addons.display.FlxGridOverlay;
import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author Ohmnivore
 */
class InfiniteGrid extends FlxSprite
{
	public function new(Size:Int = 64, Width:Int, Height:Int) 
	{
		super();
		
		loadGraphicFromSprite(FlxGridOverlay.create(Size, Size, Width, Height,
			false, true));
		alpha = 0.3;
	}
}