package states;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIPopup;
import flixel.addons.ui.FlxUIText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import openfl.geom.Rectangle;
import ui.AssetsGr;
import flixel.addons.ui.interfaces.IFlxUIWidget;

/**
 * ...
 * @author Ohmnivore
 */
class Confirm extends FlxUIPopup
{
	private var back:FlxUI9SliceSprite;
	private var go:FlxUIButton;
	private var cancel:FlxUIButton;
	
	public var callback:Void->Void;
	
	public function new(Callback:Void->Void)
	{
		super();
		callback = Callback;
	}
	
	override public function create():Void 
	{
		super.create();
		clear();
		
		var shade:FlxSprite = new FlxSprite(0, 0);
		shade.makeGraphic(FlxG.width, FlxG.height, 0x88000000, true);
		add(shade);
		
		back = new FlxUI9SliceSprite(0, 0, AssetsGr.CHROME,
			new Rectangle(0, 0, FlxG.width / 3.0, FlxG.height / 6.0));
		FlxSpriteUtil.screenCenter(back);
		add(back);
		
		var notify:FlxUIText = new FlxUIText();
		notify.text = "You have unsaved changes. Continue anyway?";
		AssetsGr.setTextStyle(notify);
		FlxSpriteUtil.screenCenter(notify);
		add(notify);
		
		go = new FlxUIButton(0, 0, "Yes", call);
		AssetsGr.setBtnGraphic(go);
		go.x = back.x + 4;
		go.y = back.y + back.height - go.height - 4;
		add(go);
		
		cancel = new FlxUIButton(0, 0, "Cancel", close);
		AssetsGr.setBtnGraphic(cancel);
		cancel.x = back.x + back.width - cancel.width - 4;
		cancel.y = back.y + back.height - go.height - 4;
		add(cancel);
		
		_ui.scrollFactor.set();
		_ui.cameras = [FlxG.camera];
		shade.cameras = [FlxG.camera];
		back.cameras = [FlxG.camera];
		notify.cameras = [FlxG.camera];
		go.cameras = [FlxG.camera];
		cancel.cameras = [FlxG.camera];
	}
	
	private function call():Void
	{
		callback();
		close();
	}
	
	override public function getEvent(id:String, sender:IFlxUIWidget, data:Dynamic, ?eventParams:Array<Dynamic>):Void 
	{
		//super.getEvent(id, sender, data, ?eventParams);
	}
}