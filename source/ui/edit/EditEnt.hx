package ui.edit;
import flixel.math.FlxPoint;
import flixel.util.FlxSpriteUtil;
import save.Entity;

/**
 * ...
 * @author Ohmnivore
 */
class EditEnt extends EditBase
{
	public var ent:Entity;
	private var entColor:Int;
	private var entFillColor:Int;
	private var old:FlxPoint;
	private var oldSelect:Bool = false;
	
	override public function set_selected(V:Bool):Bool 
	{
		_selected = V;
		return _selected;
	}
	
	public function new(Ent:Entity, X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		ent = Ent;
		entColor = Std.parseInt(Ent.color) + 0xff000000;
		entFillColor = Std.parseInt(Ent.color) + 0xaa000000;
		
		makeGraphic(Std.parseInt(Ent.width), Std.parseInt(Ent.height),
			0x0, true);
		old = new FlxPoint(-1, -1);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (old.x != width || old.y != height || oldSelect != selected)
		{
			old.set(width, height);
			oldSelect = selected;
			makeGraphic(cast width, cast height, 0x0, true);
			if (_selected)
				FlxSpriteUtil.drawRect(this, 0, 0, width, height, entFillColor,
					{ thickness:4.0, color:entColor } );
			else
				FlxSpriteUtil.drawRect(this, 0, 0, width, height, entFillColor);
		}
	}
}