package ui;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;

/**
 * ...
 * @author Ohmnivore
 */
class LayerGroup extends ShyGroup
{
	private var layers:Map<String, ShyGroup>;
	
	public function new(Layers:Array<String>) 
	{
		super();
		layers = new Map<String, ShyGroup>();
		
		for (layer in Layers)
		{
			var g:ShyGroup = new ShyGroup();
			add(g);
			
			layers.set(layer, g);
		}
	}
	
	public function get(Name:String):ShyGroup
	{
		return layers.get(Name);
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