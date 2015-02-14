package ui.edit;
import file.ImageHandler;
import flixel.FlxSprite;

/**
 * ...
 * @author Ohmnivore
 */
class EditImg extends FlxSprite
{
	public var path:String;
	
	public function new(X:Float, Y:Float, Path:String)
	{
		path = Path;
		super(X, Y);
		
		new ImageHandler(Path, this);
	}	
}