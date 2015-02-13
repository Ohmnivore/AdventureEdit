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
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		
		back = new FlxUI9SliceSprite(0, 0, null, new Rectangle(0, 0, 88, 176));
		add(back);
		
		addTool("Add");
		addTool("Remove");
		addTool("Select");
		addTool("Move");
	}
	
	private function addTool(Name:String):Void
	{
		var btn:FlxUIButton = new FlxUIButton(4, 4, Name);
		btn.has_toggle = true;
		btn.toggled = false;
		add(btn);
		
		if (lastBtn != null)
		{
			btn.y = lastBtn.y + lastBtn.height + 4;
		}
		lastBtn = btn;
	}
}