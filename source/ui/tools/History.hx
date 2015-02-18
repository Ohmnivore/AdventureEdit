package ui.tools;
//import flixel.FlxG;
import save.Level;
import ui.LayerGroup;

/**
 * ...
 * @author Ohmnivore
 */
class History
{
	private var history:Array<Level> = [];
	private var index:Int = 0;
	private var layers:LayerGroup;
	
	public function new(L:LayerGroup) 
	{
		layers = L;
		
		//FlxG.watch.add(this, "history", "History");
		//FlxG.watch.add(this, "index", "History Index");
	}
	
	public function addHistory():Void
	{
		if (index < history.length - 1)
		{
			history = history.slice(0, index + 1);
		}
		
		history.push(Reg.level.getCopy());
		index = history.length - 1;
	}
	
	public function undo():Void
	{
		index--;
		if (index < 0)
			index = 0;
		
		apply();
	}
	
	public function redo():Void
	{
		index++;
		if (index >= history.length)
			index = history.length - 1;
		
		apply();
	}
	
	private function apply():Void
	{
		if (history.length > 0)
		{
		for (l in layers.editGroups.members)
		{
			var g:ShyGroup = cast l;
			g.clear();
		}
		
		Reg.level = history[index];
		Reg.level.parseXML();
		
		//Reg.copy = [];
		Reg.selected = [];
		Reg.level.saved = false;
		}
	}
}