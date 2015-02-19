package ui;
import ext.OrderedMap;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIInputText;
import save.Entity;

/**
 * ...
 * @author Ohmnivore
 */
class EntList extends SimpleList
{
	private var setWidth:FlxUIInputText;
	private var setHeight:FlxUIInputText;
	private var setLimit:FlxUIInputText;
	private var setColor:FlxUIInputText;
	private var values:ValueList;
	
	public var ents:OrderedMap<String, Entity>;
	
	public function new(X:Float, Y:Float, V:ValueList, W:FlxUIInputText, H:FlxUIInputText,
		L:FlxUIInputText, C:FlxUIInputText) 
	{
		values = V;
		setWidth = W;
		setHeight = H;
		setLimit = L;
		setColor = C;
		
		ents = new OrderedMap<String, Entity>(new Map<String, Entity>());
		super(X, Y);
		newName = "newEntity";
	}
	
	override function unToggle():Void 
	{
		if (currentEdit != null)
		{
			//trace(currentEdit.label.text, editName.text);
			var ent:Entity = ents.get(currentEdit.label.text);
			ents.set(editName.text, ent);
			if (editName.text != currentEdit.label.text)
				ents.remove(currentEdit.label.text);
			ent.width = setWidth.text;
			ent.height = setHeight.text;
			ent.limit = setLimit.text;
			ent.color = setColor.text;
			ent.name = currentEdit.label.text;
			
			ent.props = new OrderedMap<String, String>(new Map<String, String>());
			for (p in values.defs.keys())
			{
				ent.props.set(p, values.defs.get(p));
			}
		}
		
		super.unToggle();
	}
	
	public function addNewEnt(Ent:Entity):Void
	{
		ents.set(Ent.name, Ent);
		super.addNew(Ent.name);
	}
	
	override function makeNew():Void 
	{
		ents.set(newName, new Entity());
		super.makeNew();
	}
	
	override function edit(Btn:FlxUIButton):Void 
	{
		super.edit(Btn);
		var ent:Entity = ents.get(currentEdit.label.text);
		if (ent == null)
		{
			ent = new Entity();
			ents.set(currentEdit.label.text, ent);
		}
		
		setWidth.text = ent.width;
		setHeight.text = ent.height;
		setLimit.text = ent.limit;
		setColor.text = ent.color;
		
		values.list.clear();
		values.defs = new OrderedMap<String, String>(new Map<String, String>());
		for (p in ent.props.keys())
		{
			values.addNew(p, ent.props.get(p));
		}
	}
	
	override function removeBtn():Void 
	{
		if (currentEdit != null)
		{
			ents.remove(currentEdit.label.text);
		}
		super.removeBtn();
	}
}