package ui;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.FlxUIText;

/**
 * ...
 * @author Ohmnivore
 */
class SimpleValueList extends FlxUIGroup
{
	public var list:FlxUIList;
	
	private var currentEdit:FlxUIButton;
	
	private var editUI:FlxUIGroup;
	private var editValue:FlxUIInputText;
	private var dEditValue:FlxUIText;
	
	public var defs:Map<String, String>;
	
	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		
		list = new FlxUIList(0, 20, null, 80, 240, "<X> more...");
		AssetsGr.setListStyle(list);
		add(list);
		
		//Edit UI
		editUI = new FlxUIGroup(list.width + 10, 20);
		add(editUI);
		
		dEditValue = new FlxUIText();
		dEditValue.text = "Name";
		
		editValue = new FlxUIInputText();
		editValue.x = dEditValue.width + 10;
		editValue.text = "";
		
		editUI.add(dEditValue);
		editUI.add(editValue);
		
		defs = new Map<String, String>();
	}
	
	public function unToggle():Void
	{
		if (currentEdit != null)
		{
			defs.set(currentEdit.label.text, StringTools.trim(editValue.text));
		}
		
		for (m in list.members)
		{
			var btn:FlxUIButton = cast m;
			btn.toggled = false;
		}
	}
	
	public function addNew(Name:String, Value:String):Void
	{
		unToggle();
		
		var newBtn:FlxUIButton = new FlxUIButton(0, 0, Name);
		AssetsGr.setBtnGraphic(newBtn);
		newBtn.has_toggle = true;
		newBtn.toggled = true;
		newBtn.onUp.callback = function() { edit(newBtn); };
		defs.set(Name, Value);
		edit(newBtn);
		
		currentEdit = newBtn;
		list.add(newBtn);
	}
	
	private function edit(Btn:FlxUIButton, Default:String = null):Void
	{
		unToggle();
		Btn.toggled = true;
		
		if (defs.exists(Btn.label.text))
			editValue.text = defs.get(Btn.label.text);
		else
			editValue.text = "";
		
		currentEdit = Btn;
	}
}