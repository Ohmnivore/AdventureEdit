package states;
import file.Base;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUITabMenu;
import flixel.FlxG;
import openfl.geom.Rectangle;
import ui.EntList;
import ui.panels.LayerPanel;
import ui.panels.ToolPanel;
import ui.select.List;
import ui.SimpleList;
import ui.ValueList;
//import FlxI

/**
 * ...
 * @author Ohmnivore
 */
class Main extends FlxUIState
{
	private var back:FlxUIGroup;
	private var menuProj:FlxUIDropDownMenu;
	
	override public function create():Void 
	{
		_xml_id = "main";
		super.create();
		
		menuProj = cast _ui.getAsset("project");
		menuProj.callback = handleProject;
		back = _ui.getGroup("background");
		
		if (Reg.project != null)
		{
			FlxG.camera.bgColor = Std.parseInt(Reg.project.bgColor) + 0xff000000;
			
			back.add(new FlxUI9SliceSprite(0, FlxG.height - 72, null, new Rectangle(0, 0, FlxG.width, 72)));
			back.add(new List(0, FlxG.height - 68, FlxG.width));
			
			back.add(new LayerPanel(4, 32, Reg.project.layers));
			back.add(new ToolPanel(FlxG.width - 92, 32));
		}
	}
	
	private function handleProject(ID:String):Void
	{
		if (ID == "newproj")
		{
			Reg.project = null;
			FlxG.switchState(new EditProject(Base.newProject()));
		}
		else if (ID == "openproj")
		{
			Reg.project = null;
			var newState:EditProject = new EditProject(Base.openProject(), true);
			FlxG.switchState(newState);
		}
		else if (ID == "editproj" && Reg.project != null)
		{
			FlxG.switchState(new EditProject(Reg.project.path));
		}
		else if (ID == "closeproj")
		{
			Reg.project = null;
			FlxG.switchState(new Main());
		}
	}
}