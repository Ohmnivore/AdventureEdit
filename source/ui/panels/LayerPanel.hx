package ui.panels;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIGroup;
import haxe.Constraints.Function;
import openfl.geom.Rectangle;
import ui.LayerGroup;

/**
 * ...
 * @author Ohmnivore
 */
class LayerPanel extends FlxUIGroup
{
	private var back:FlxUI9SliceSprite;
	private var lastBtn:FlxUIButton;
	
	public var currentLayer:String;
	public var layers:LayerGroup;
	
	public function new(X:Float, Y:Float, Layers:Array<String>, LGroup:LayerGroup) 
	{
		super(X, Y);
		layers = LGroup;
		
		back = new FlxUI9SliceSprite(0, 0, AssetsGr.CHROME, new Rectangle(0, 0, 88 + 22, 176));
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
		AssetsGr.setBtnGraphic(btn);
		btn.onUp.callback = function() { toggle(btn); };
		btn.has_toggle = true;
		add(btn);
		
		if (lastBtn != null)
		{
			btn.y = lastBtn.y + lastBtn.height + 4;
		}
		lastBtn = btn;
		
		toggle(lastBtn);
		
		var visibleToggle:FlxUICheckBox = new FlxUICheckBox(0, btn.y - 30, null, null, "");
		visibleToggle.x = btn.x + btn.width;
		visibleToggle.checked = true;
		visibleToggle.callback = function() {
			layers.get(Name).visible = visibleToggle.checked;
		};
		add(visibleToggle);
	}
}