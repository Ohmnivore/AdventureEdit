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
class EditImg extends FlxSprite
{
	public var path:String;
	
	private var glow:GlowFilter;
	private var drop:DropShadowFilter;
	private var filter:FlxFilterFrames;
	private var tween:FlxTween;
	
	private var _selected:Bool = false;
	public var selected(get, set):Bool;
	public function get_selected():Bool
	{
		return _selected;
	}
	public function set_selected(V:Bool):Bool
	{
		_selected = V;
		
		if (_selected)
		{
			color = 0xffffcccc;
			if (filter != null)
				filter.addFilter(drop);
		}
		else
		{
			color = 0xffffffff;
			if (filter != null)
				filter.clearFilters();
		}
		
		return _selected;
	}
	
	public function new(X:Float, Y:Float, P:String)
	{
		path = P;
		super(X, Y);
		cameras = [Reg.backCam];
		
		//if (P)
		//{
			//path = Path.join([
				//Path.directory(Reg.project.path),
				//path
			//]);
		//}
		
		new ImageHandler(P, this, addFilter);
	}
	
	private function addFilter(S:FlxSprite):Void
	{
		drop = new DropShadowFilter(0, 0, 0xff0000, .75, 10, 10, 2, 1);
		filter = FlxFilterFrames.fromFrames(frames, 50, 50);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (filter != null && selected)
			filter.applyToSprite(this, false, true);
	}
}