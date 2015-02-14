package ui.panels;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import haxe.Constraints.Function;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Ohmnivore
 */
class LayerPanel extends FlxUIGroup
{
	private var back:FlxUI9SliceSprite;
	private var lastBtn:FlxUIButton;
	
	public var currentLayer:String;
	
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
	
	private function unToggleAll():Void
	{
		for (m in members)
		{
			if (Std.is(m, FlxUIButton))
			{
				var btn:FlxUIButton = cast m;
				btn.toggled = false;
			}
		}
	}
	
	private function toggle(B:FlxUIButton):Void
	{
		unToggleAll();
		
		B.toggled = true;
		currentLayer = B.label.text;
	}
	
	private function addLayer(Name:String):Void
	{
		var btn:FlxUIButton = new FlxUIButton(4, 4, Name);
		btn.onUp.callback = function() { toggle(btn); };
		btn.has_toggle = true;
		add(btn);
		
		if (lastBtn != null)
		{
			btn.y = lastBtn.y + lastBtn.height + 4;
		}
		lastBtn = btn;
		
		toggle(lastBtn);
	}
}