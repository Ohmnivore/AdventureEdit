package ui.tools;
import file.ImageHandler;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIList;
import flixel.FlxSprite;
import haxe.io.Path;
import save.Cookies;
import sys.FileSystem;
import flixel.ui.FlxButton;
import ui.edit.EditEnt;
import ui.edit.EditImg;
import ui.tools.SelectThumbnail;

/**
 * ...
 * @author Ohmnivore
 */
class SelectList extends FlxUIList
{
	public function new(X:Float, Y:Float, Width:Float)
	{
		super(X + 64, Y, [], Width - 128, 0, "<X> more...", FlxUIList.STACK_HORIZONTAL, 3);
		
		AssetsGr.setListStyle(this);
		setThumbs();
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
	
	public function setThumbs():Void
	{
		clear();
		for (s in Reg.selected)
		{
			if (s.alive)
			{
				if (Std.is(s, EditImg))
				{
					var thumb:SelectThumbnail = new SelectThumbnail(0, 0, cast s, onSelect);
					
					var scale:Float = 64.0 / thumb.width;
					if (thumb.width < thumb.height)
					{
						scale = 64.0 / thumb.height;
					}
					thumb.scale.set(scale, scale);
					thumb.updateHitbox();
					
					add(thumb);
				}
				else
				{
					var e:EditEnt = cast s;
					var thumb:EntityThumbnail = new EntityThumbnail(e.ent, onSelect2);
					thumb.editEnt = e;
					add(thumb);
				}
			}
		}
	}
	
	private function onSelect(T:SelectThumbnail):Void
	{
		for (s in Reg.selected)
		{
			if (s.alive)
				s.selected = false;
		}
		Reg.selected = [];
		
		var single:EditImg = cast T.toCopy;
		single.selected = true;
		Reg.selected.push(single);
		
		setThumbs();
	}
	private function onSelect2(T:EntityThumbnail):Void
	{
		for (s in Reg.selected)
		{
			if (s.alive)
				s.selected = false;
		}
		Reg.selected = [];
		
		var single:EditEnt = T.editEnt;
		single.selected = true;
		Reg.selected.push(single);
		
		setThumbs();
	}
}