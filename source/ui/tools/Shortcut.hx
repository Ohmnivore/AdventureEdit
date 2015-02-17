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
		
		if (FlxG.keys.justPressed.CONTROL)
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
				m.handleLvl("undo");
			else if (FlxG.keys.justPressed.Y)
				m.handleLvl("redo");
			else if (FlxG.keys.justPressed.X)
				m.handleLvl("cut");
			else if (FlxG.keys.justPressed.C)
				m.handleLvl("copy");
			else if (FlxG.keys.justPressed.V)
				m.handleLvl("paste");
			else if (FlxG.keys.justPressed.A)
				m.handleLvl("selectall");
			else if (FlxG.keys.justPressed.D)
				m.handleLvl("deselect");
			
			//View
			else if (FlxG.keys.justPressed.G)
				m.handleView("grid");
			else if (FlxG.keys.justPressed.HOME)
				m.handleView("centerview");
		}
		if (FlxG.keys.justPressed.SHIFT && FlxG.keys.justPressed.CONTROL)
		{
			if (FlxG.keys.justPressed.S)
				m.handleLvl("savelvlas");
		}
	}
}