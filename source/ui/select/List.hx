package ui.select;
import file.ImageHandler;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIList;
import flixel.FlxSprite;
import haxe.io.Path;
import sys.FileSystem;
import openfl.utils.SystemPath;
import flixel.ui.FlxButton;

/**
 * ...
 * @author Ohmnivore
 */
class List extends FlxUIList
{
	public function new(X:Float, Y:Float, Width:Float)
	{
		super(X + 64, Y, [], Width - 128, 0, "<X> more...", FlxUIList.STACK_HORIZONTAL, 3);
		
		walk(SystemPath.desktopDirectory);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		//Adjust scrolling speed
		var next:FlxUIButton = cast nextButton;
		if (next.status == FlxButton.PRESSED)
		{
			scrollIndex += 1;
		}
		var prev:FlxUIButton = cast prevButton;
		if (prev.status == FlxButton.PRESSED)
		{
			scrollIndex -= 1;
		}
	}
	
	private function walk(P:String):Void
	{
		clear();
		scrollIndex = 0;
		
		var up:FlxUIButton = new FlxUIButton(0, 0, "..", function() {
			walk(Path.directory(P));
		});
		add(up);
		
		for (item in FileSystem.readDirectory(P))
		{
			var fullPath:String = Path.join([P, item]);
			
			if (FileSystem.isDirectory(fullPath))
			{
				var btn:FlxUIButton = new FlxUIButton(0, 0, cutName(item), function() {
					walk(fullPath);
				});
				
				add(btn);
			}
		}
		
		for (item in FileSystem.readDirectory(P))
		{
			var fullPath:String = Path.join([P, item]);
			var ext:String = Path.extension(item);
			
			if (FileSystem.isDirectory(fullPath) == false && ext == "png")
			{
				//Png file, so add a thumbnail
				var s:Thumbnail = new Thumbnail(0, 0);
				new ImageHandler(fullPath, s, function(S:FlxSprite) {
					var scale:Float = 64.0 / S.width;
					if (S.width < S.height)
					{
						scale = 64.0 / S.height;
					}
					S.scale.set(scale, scale);
					S.updateHitbox();
					
					add(S);
				});
			}
		}
	}
	
	private function cutName(Name:String):String
	{
		var max:Int = 12;
		
		if (Name.length > max)
			return Name.substr(0, max);
		else
			return Name;
	}
}