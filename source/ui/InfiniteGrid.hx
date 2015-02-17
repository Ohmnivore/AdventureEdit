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
			false, true, 0x00000000, 0xffe7e6e6));
		alpha = 0.3;
	}
}