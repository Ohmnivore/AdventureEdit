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
class ValueList extends FlxUIGroup
{
	private var header:FlxUIText;
	public var list:FlxUIList;
	private var btnCreate:FlxUIButton;
	private var btnRemove:FlxUIButton;
	
	private var currentEdit:FlxUIButton;
	
	private var editUI:FlxUIGroup;
	private var editName:FlxUIInputText;
	private var editDefault:FlxUIInputText;
	private var dEditName:FlxUIText;
	private var dEditDefault:FlxUIText;
	
	public var defs:Map<String, String>;
	
	public function new(X:Float, Y:Float, Header:String)
	{
		super(X, Y);
		
		header = new FlxUIText();
		header.x = 0;
		header.y = 0;
		header.text = Header;
		
		list = new FlxUIList(0, header.height + 20, null, 80, 240, "<X> more...");
		
		btnCreate = new FlxUIButton(list.width + 10, list.x + list.height - 20,
			"Create", makeNew);
		btnRemove = new FlxUIButton(list.width + 94, btnCreate.y,
			"Remove", removeBtn);
		
		add(header);
		add(list);
		add(btnCreate);
		add(btnRemove);
		
		//Edit UI
		editUI = new FlxUIGroup(list.width + 10, header.height + 20);
		add(editUI);
		
		dEditName = new FlxUIText();
		dEditName.text = "Name";
		
		editName = new FlxUIInputText();
		editName.x = dEditName.width + 10;
		editName.text = "";
		
		dEditDefault = new FlxUIText();
		dEditDefault.x = editName.x + editName.width + 10;
		dEditDefault.text = "Default";
		
		editDefault = new FlxUIInputText();
		editDefault.x = dEditDefault.x + dEditDefault.width + 10;
		editDefault.text = "";
		
		editUI.add(dEditName);
		editUI.add(editName);
		editUI.add(dEditDefault);
		editUI.add(editDefault);
		
		defs = new Map<String, String>();
	}
	
	private function unToggle():Void
	{
		if (currentEdit != null)
		{
			currentEdit.label.text = editName.text;
			defs.set(currentEdit.label.text, StringTools.trim(editDefault.text));
		}
		
		for (m in list.members)
		{
			var btn:FlxUIButton = cast m;
			btn.toggled = false;
		}
	}
	
	private function makeNew():Void
	{
		unToggle();
		
		var name:String = "newVal";
		var newBtn:FlxUIButton = new FlxUIButton(0, 0, name);
		newBtn.has_toggle = true;
		newBtn.toggled = true;
		newBtn.onUp.callback = function() { edit(newBtn); };
		edit(newBtn);
		
		currentEdit = newBtn;
		list.add(newBtn);
	}
	
	public function addNew(Name:String, Default:String):Void
	{
		unToggle();
		
		var newBtn:FlxUIButton = new FlxUIButton(0, 0, Name);
		newBtn.has_toggle = true;
		newBtn.toggled = true;
		newBtn.onUp.callback = function() { edit(newBtn); };
		defs.set(Name, Default);
		edit(newBtn);
		
		currentEdit = newBtn;
		list.add(newBtn);
	}
	
	private function edit(Btn:FlxUIButton, Default:String = null):Void
	{
		unToggle();
		Btn.toggled = true;
		
		editName.text = Btn.label.text;
		if (defs.exists(editName.text))
			editDefault.text = defs.get(editName.text);
		else
			editDefault.text = "";
		
		currentEdit = Btn;
	}
	
	private function removeBtn():Void
	{
		if (currentEdit != null)
		{
			list.remove(currentEdit, true);
			
			currentEdit.kill();
			currentEdit.destroy();
			currentEdit = null;
		}
	}
}