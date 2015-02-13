package ui.panels;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Ohmnivore
 */
class LayerPanel extends FlxUIGroup
{
	private var back:FlxUI9SliceSprite;
	private var lastBtn:FlxUIButton;
	
	public function new(X:Float, Y:Float, Layers:Array<String>) 
	{
		super(X, Y);
		
		back = new FlxUI9SliceSprite(0, 0, null, new Rectangle(0, 0, 88, 176));
		add(back);
		
		for (l in Layers)
		{
			addLayer(l);
		}
	}
	
	private function addLayer(Name:String):Void
	{
		var btn:FlxUIButton = new FlxUIButton(4, 4, Name);
		btn.has_toggle = true;
		add(btn);
		
		if (lastBtn != null)
		{
			btn.y = lastBtn.y + lastBtn.height + 4;
		}
		lastBtn = btn;
	}
}