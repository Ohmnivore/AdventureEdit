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
class SimpleList extends FlxUIGroup
{
	private var btnCreate:FlxUIButton;
	private var btnRemove:FlxUIButton;
	private var btnUp:FlxUIButton;
	private var btnDown:FlxUIButton;
	
	public var list:ListExt;
	
	private var currentEdit:FlxUIButton;
	
	private var editName:FlxUIInputText;
	private var dEditName:FlxUIText;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		
		list = new ListExt(0, 0, null, 80, 400);
		
		dEditName = new FlxUIText();
		dEditName.x = 90;
		dEditName.text = "Name";
		
		editName = new FlxUIInputText();
		editName.x = dEditName.x + dEditName.width + 10;
		editName.text = "";
		
		btnCreate = new FlxUIButton(0, list.height + 10, "Create", makeNew);
		btnRemove = new FlxUIButton(btnCreate.width + 10, btnCreate.y, "Remove", removeBtn);
		btnUp = new FlxUIButton(0, btnCreate.y + btnCreate.height + 10, "Move Up", moveBtnUp); 
		btnDown = new FlxUIButton(btnUp.width + 10, btnUp.y, "Move Down", moveBtnDown); 
		
		add(list);
		add(dEditName);
		add(editName);
		add(btnCreate);
		add(btnRemove);
		add(btnUp);
		add(btnDown);
	}
	
	private function unToggle():Void
	{
		if (currentEdit != null)
			currentEdit.label.text = editName.text;
		
		for (m in list.members)
		{
			var btn:FlxUIButton = cast m;
			btn.toggled = false;
		}
	}
	
	private function makeNew():Void
	{
		unToggle();
		
		var name:String = "newLayer";
		var newBtn:FlxUIButton = new FlxUIButton(0, 0, name);
		newBtn.has_toggle = true;
		newBtn.toggled = true;
		newBtn.onUp.callback = function() { edit(newBtn); };
		edit(newBtn);
		
		currentEdit = newBtn;
		list.add(newBtn);
	}
	
	public function addNew(Name:String):Void
	{
		unToggle();
		
		var newBtn:FlxUIButton = new FlxUIButton(0, 0, Name);
		newBtn.has_toggle = true;
		newBtn.toggled = true;
		newBtn.onUp.callback = function() { edit(newBtn); };
		edit(newBtn);
		
		currentEdit = newBtn;
		list.add(newBtn);
	}
	
	private function edit(Btn:FlxUIButton):Void
	{
		unToggle();
		Btn.toggled = true;
		
		editName.text = Btn.label.text;
		
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
	
	private function moveBtnUp():Void
	{
		if (currentEdit != null)
			list.moveBtnUp(currentEdit);
	}
	
	private function moveBtnDown():Void
	{
		if (currentEdit != null)
			list.moveBtnDown(currentEdit);
	}
}