package ui.edit;
import file.ImageHandler;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFilterFrames;
import haxe.io.Path;
import haxe.macro.Context;
import openfl.filters.DropShadowFilter;
import openfl.filters.GlowFilter;
import flixel.tweens.FlxTween;
import flixel.graphics.FlxGraphic;
import flixel.system.FlxAssets.GraphicLogo;

/**
 * ...
 * @author Ohmnivore
 */
class EditImg extends EditBase
{
	public var path:String;
	
	public function new(X:Float, Y:Float, P:String)
	{
		path = P;
		super(X, Y);
		
		new ImageHandler(P, this, addFilter);
	}
	
	override public function getCopy():EditBase
	{
		var ret:EditImg = new EditImg(x, y, path);
		ret.width = width;
		ret.height = height;
		
		return ret;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
}