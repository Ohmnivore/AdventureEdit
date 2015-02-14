package states;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIPopup;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.FlxG;
import flixel.util.FlxSpriteUtil;
import openfl.geom.Rectangle;
import ui.SimpleValueList;

/**
 * ...
 * @author Ohmnivore
 */
class EditValues extends FlxUIPopup
{
	private var back:FlxUI9SliceSprite;
	private var list:SimpleValueList;
	
	private var apply:FlxUIButton;
	private var cancel:FlxUIButton;
	
	override public function create():Void 
	{
		super.create();
		
		back = new FlxUI9SliceSprite(0, 0, null, new Rectangle(0, 0, FlxG.width / 2.0, FlxG.height * 0.75));
		FlxSpriteUtil.screenCenter(back);
		add(back);
		
		list = new SimpleValueList(back.x + 4, back.y + 4);
		add(list);
		
		for (v in Reg.level.values.keys())
		{
			list.addNew(v, Reg.level.values.get(v));
		}
		
		apply = new FlxUIButton(back.x + 4, 0, "Apply", saveClose);
		apply.y = back.y + back.height - apply.height - 4;
		add(apply);
		
		cancel = new FlxUIButton(0, 0, "Cancel", close);
		cancel.y = back.y + back.height - cancel.height - 4;
		cancel.x = back.x + back.width - cancel.width - 4;
		add(cancel);
	}
	
	public function saveClose():Void
	{
		list.unToggle();
		
		for (v in list.defs.keys())
		{
			Reg.level.values.set(v, list.defs.get(v));
		}
		
		close();
	}
	
	override public function getEvent(id:String, sender:IFlxUIWidget, data:Dynamic, ?eventParams:Array<Dynamic>):Void 
	{
		//super.getEvent(id, sender, data, ?eventParams);
	}
}