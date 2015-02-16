package ui;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import ui.edit.EditImg;

/**
 * ...
 * @author Ohmnivore
 */
class LayerGroup extends ShyGroup
{
	public var cursorGroup:ShyGroup;
	
	private var layers:Map<String, ShyGroup>;
	
	public var editGroups:FlxGroup;
	
	public function new(Layers:Array<String>) 
	{
		super();
		layers = new Map<String, ShyGroup>();
		editGroups = new FlxGroup();
		
		for (layer in Layers)
		{
			var g:ShyGroup = new ShyGroup();
			add(g);
			editGroups.add(g);
			
			layers.set(layer, g);
		}
		
		cursorGroup = new ShyGroup();
		add(cursorGroup);
	}
	
	public function get(Name:String):ShyGroup
	{
		return layers.get(Name);
	}
	
	public function setAllSelection(Selected:Bool):Void
	{
		for (l in editGroups.members)
		{
			var layer:ShyGroup = cast l;
			
			for (s in layer.members)
			{
				if (Std.is(s, EditImg))
				{
					var img:EditImg = cast s;
					img.selected = Selected;
				}
			}
		}
	}
}

class ShyGroup extends FlxSpriteGroup
{
	public function new()
	{
		super(0, 0);
	}
	
	override public function add(Sprite:FlxSprite):FlxSprite 
	{
		return group.add(Sprite);
	}
}