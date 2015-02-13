package ui;
import flixel.addons.ui.FlxUIList;
import flixel.FlxSprite;

/**
 * ...
 * @author Ohmnivore
 */
class ListExt extends FlxUIList
{
	public function moveBtnUp(S:FlxSprite):Void
	{
		var id:Int = getBtnId(S);
		
		if (id > 0)
		{
			var buffer:Dynamic = group.members[id - 1];
			group.members[id - 1] = group.members[id];
			group.members[id] = buffer;
			
			refreshList();
		}
	}
	
	public function moveBtnDown(S:FlxSprite):Void
	{
		var id:Int = getBtnId(S);
		
		if (id < group.members.length - 1)
		{
			var buffer:Dynamic = group.members[id + 1];
			group.members[id + 1] = group.members[id];
			group.members[id] = buffer;
			
			refreshList();
		}
	}
	
	private function getBtnId(S:FlxSprite):Int
	{
		var i:Int = 0;
		while (i < group.members.length)
		{
			if (group.members[i] == S)
				return i;
			
			i++;
		}
		
		return -1;
	}
}