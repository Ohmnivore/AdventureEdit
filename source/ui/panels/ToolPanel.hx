package ui.panels;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIGroup;
import openfl.geom.Rectangle;
import flixel.addons.ui.FlxUIButton;

/**
 * ...
 * @author Ohmnivore
 */
class ToolPanel extends FlxUIGroup
{
	private var back:FlxUI9SliceSprite;
	private var lastBtn:FlxUIButton;
	
	public var currentTool:String;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		
		back = new FlxUI9SliceSprite(0, 0, null, new Rectangle(0, 0, 88, 176));
		add(back);
		
		toggle(addTool("Add"));
		addTool("Remove");
		addTool("Select");
		addTool("Move");
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
		currentTool = B.label.text;
	}
	
	private function addTool(Name:String):FlxUIButton
	{
		var btn:FlxUIButton = new FlxUIButton(4, 4, Name);
		btn.onUp.callback = function() { toggle(btn); };
		btn.has_toggle = true;
		btn.toggled = false;
		add(btn);
		
		if (lastBtn != null)
		{
			btn.y = lastBtn.y + lastBtn.height + 4;
		}
		lastBtn = btn;
		
		return btn;
	}
}