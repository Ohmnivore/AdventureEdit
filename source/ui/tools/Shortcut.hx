package ui.tools;
import flixel.FlxG;
import states.Main;
import ui.panels.ToolPanel;

/**
 * ...
 * @author Ohmnivore
 */
class Shortcut
{
	private var m:Main;
	private var tools:ToolPanel;
	
	public function new(M:Main, Tools:ToolPanel)
	{
		m = M;
		tools = Tools;
	}
	
	public function update():Void
	{
		//Tools
		if (FlxG.keys.justPressed.ONE)
			tools.setTool("Add");
		else if (FlxG.keys.justPressed.TWO)
			tools.setTool("Remove");
		else if (FlxG.keys.justPressed.THREE)
			tools.setTool("Select");
		else if (FlxG.keys.justPressed.FOUR)
			tools.setTool("Move");
		
		//Zoom
		if (FlxG.mouse.wheel > 0)
			m.handleView("zoomin");
		if (FlxG.mouse.wheel < 0)
			m.handleView("zoomout");
		
		if (FlxG.keys.pressed.CONTROL)
		{
			//Lvl
			if (FlxG.keys.justPressed.L)
				m.handleLvl("lvlprop");
			else if (FlxG.keys.justPressed.N)
				m.handleLvl("newlvl");
			else if (FlxG.keys.justPressed.O)
				m.handleLvl("openlvl");
			else if (FlxG.keys.justPressed.S)
				m.handleLvl("savelvl");
			else if (FlxG.keys.justPressed.W)
				m.handleLvl("closelvl");
			
			//Edit
			else if (FlxG.keys.justPressed.Z)
				m.handleEdit("undo");
			else if (FlxG.keys.justPressed.Y)
				m.handleEdit("redo");
			else if (FlxG.keys.justPressed.X)
				m.handleEdit("cut");
			else if (FlxG.keys.justPressed.C)
				m.handleEdit("copy");
			else if (FlxG.keys.justPressed.V)
				m.handleEdit("paste");
			else if (FlxG.keys.justPressed.A)
				m.handleEdit("selectall");
			else if (FlxG.keys.justPressed.D)
				m.handleEdit("deselect");
			
			//View
			else if (FlxG.keys.justPressed.G)
				m.handleView("grid");
			else if (FlxG.keys.justPressed.TAB)
				m.handleView("centerview");
		}
		if (FlxG.keys.pressed.SHIFT && FlxG.keys.pressed.CONTROL)
		{
			if (FlxG.keys.justPressed.S)
				m.handleLvl("savelvlas");
		}
	}
}