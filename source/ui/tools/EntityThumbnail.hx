package ui.tools;
import flixel.addons.ui.FlxClickArea;
import flixel.addons.ui.FlxUIText;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.FlxG;
import flixel.util.FlxSpriteUtil;
import save.Entity;
import ui.edit.EditEnt;

/**
 * ...
 * @author Ohmnivore
 */
class EntityThumbnail extends FlxUIText
{
	public var callback:EntityThumbnail->Void;
	public var ent:Entity;
	public var editEnt:EditEnt;
	public var selected:Bool = false;
	private var area:FlxClickArea;
	
	public function new(Ent:Entity, Callback:EntityThumbnail->Void = null) 
	{
		callback = Callback;
		ent = Ent;
		super();
		
		text = ent.name;
		color = Std.parseInt(ent.color) + 0xff000000;
		setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xffffffff);
		
		area = new FlxClickArea(0, 0, width, height, call);
		FlxG.state.add(area);
	}
	
	override public function draw():Void 
	{
		if (selected)
		{
			FlxSpriteUtil.drawRect(this, 0, 0, width, height,
				0x0, { thickness:4, color:0xffff0000 }, { } );
		}
		super.draw();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		area.x = x;
		area.y = y;
		area.width = width;
		area.height = 64;
	}
	
	private function call():Void
	{
		if (callback != null)
			callback(this);
	}
}