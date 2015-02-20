package ui.tools;
import file.ImageHandler;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIList;
import flixel.FlxSprite;
import haxe.io.Path;
import save.Cookies;
import sys.FileSystem;
import flixel.ui.FlxButton;
import ui.edit.EditImg;
import ui.tools.SelectThumbnail;

/**
 * ...
 * @author Ohmnivore
 */
class EntityList extends FlxUIList
{
	public function new(X:Float, Y:Float, Width:Float)
	{
		super(X + 64, Y, [], Width - 128, 0, "<X> more...", FlxUIList.STACK_HORIZONTAL, 3);
		
		AssetsGr.setListStyle(this);
		setEnts();
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
	
	public function setEnts():Void
	{
		clear();
		for (e in Reg.project.entities)
		{
			var thumb:EntityThumbnail = new EntityThumbnail(e, onSelect);
			add(thumb);
		}
	}
	
	private function unToggle():Void
	{
		for (s in members)
		{
			var t:EntityThumbnail = cast s;
			t.selected = false;
		}
	}
	
	private function onSelect(T:EntityThumbnail):Void
	{
		Reg.curEnt = T.ent;
		unToggle();
		T.selected = true;
	}
}