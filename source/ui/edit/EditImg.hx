package ui.edit;
import file.ImageHandler;
import flixel.FlxSprite;
import haxe.io.Path;
import haxe.macro.Context;

/**
 * ...
 * @author Ohmnivore
 */
class EditImg extends FlxSprite
{
	public var path:String;
	
	public function new(X:Float, Y:Float, P:String)
	{
		path = P;
		super(X, Y);
		
		//if (P)
		//{
			//path = Path.join([
				//Path.directory(Reg.project.path),
				//path
			//]);
		//}
		
		new ImageHandler(P, this);
	}	
}