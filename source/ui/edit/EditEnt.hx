package ui.edit;
import ext.OrderedMap;
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
	public var props:OrderedMap<String, String>;
	
	private var entColor:Int;
	private var entFillColor:Int;
	private var old:FlxPoint;
	private var oldSelect:Bool = false;
	
	override public function set_selected(V:Bool):Bool 
	{
		_selected = V;
		return _selected;
	}
	
	public function new(Ent:Entity = null, X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		props = new OrderedMap<String, String>(new Map<String, String>());
		ent = Ent;
		if (ent != null)
		{
			entColor = Std.parseInt(Ent.color) + 0xff000000;
			entFillColor = Std.parseInt(Ent.color) + 0xaa000000;
			
			makeGraphic(Std.parseInt(Ent.width), Std.parseInt(Ent.height),
				0x0, true);
			for (p in ent.props.keys())
			{
				props.set(p, ent.props.get(p));
			}
		}
		else
		{
			makeGraphic(16, 16, 0x0, true);
		}
		old = new FlxPoint(-1, -1);
	}
	
	public function getXML():Xml
	{
		var xml:Xml = Xml.createElement("entity");
		xml.set("name", ent.name);
		xml.set("x", Std.string(x));
		xml.set("y", Std.string(y));
		xml.set("width", Std.string(width));
		xml.set("height", Std.string(height));
		
		for (p in props.keys())
		{
			var sub:Xml = Xml.createElement(p);
			sub.set("value", props.get(p));
			xml.addChild(sub);
		}
		
		return xml;
	}
	
	public function loadXml(X:Xml):Void
	{
		for (e in Reg.project.entities)
		{
			if (e.name == X.get("name"))
				ent = e;
		}
		x = Std.parseFloat(X.get("x"));
		y = Std.parseFloat(X.get("y"));
		width = Std.parseFloat(X.get("width"));
		height = Std.parseFloat(X.get("height"));
		
		entColor = Std.parseInt(ent.color) + 0xff000000;
		entFillColor = Std.parseInt(ent.color) + 0xaa000000;
		
		for (sub in X.iterator())
		{
			props.set(sub.nodeName, sub.get("value"));
		}
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