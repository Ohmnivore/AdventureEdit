package ui.select;
import file.ImageHandler;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIList;
import flixel.FlxSprite;
import haxe.io.Path;
import save.Cookies;
import sys.FileSystem;
import flixel.ui.FlxButton;

/**
 * ...
 * @author Ohmnivore
 */
class List extends FlxUIList
{
	public var currentThumb:Thumbnail;
	
	public function new(X:Float, Y:Float, Width:Float)
	{
		super(X + 64, Y, [], Width - 128, 0, "<X> more...", FlxUIList.STACK_HORIZONTAL, 3);
		
		var prevPath:String = Cookies.get("prevPath");
		if (!Cookies.isValidPath(prevPath))
			prevPath = Cookies.desktopPath();
		walk(prevPath);
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
		Cookies.set("prevPath", P);
		
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
				var s:Thumbnail = new Thumbnail(0, 0, fullPath);
				s.callback = toggle;
				
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
	
	private function unToggleAll():Void
	{
		for (m in members)
		{
			if (Std.is(m, Thumbnail))
			{
				var t:Thumbnail = cast m;
				t.toggled = false;
			}
		}
	}
	
	private function toggle(T:Thumbnail):Void
	{
		var buffer:Bool = T.toggled;
		unToggleAll();
		T.toggled = buffer;
		
		if (T.toggled)
			currentThumb = T;
		else
			currentThumb = null;
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