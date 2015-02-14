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
import save.Cookies;
import ui.EntList;
import ui.LayerGroup;
import ui.panels.LayerPanel;
import ui.panels.ToolPanel;
import ui.select.List;
import ui.SimpleList;
import ui.ValueList;
import ui.tools.Add;

/**
 * ...
 * @author Ohmnivore
 */
class Main extends FlxUIState
{
	private var back:FlxUIGroup;
	private var menuProj:FlxUIDropDownMenu;
	
	private var select:List;
	private var layers:LayerGroup;
	private var layerPanel:LayerPanel;
	private var tools:ToolPanel;
	
	private var addTool:Add;
	
	private static var opened:Bool = false;
	
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
			
			layers = new LayerGroup(Reg.project.layers);
			select = new List(0, FlxG.height - 68, FlxG.width);
			layerPanel = new LayerPanel(4, 32, Reg.project.layers);
			tools = new ToolPanel(FlxG.width - 92, 32);
			
			back.add(layers);
			back.add(new FlxUI9SliceSprite(0, FlxG.height - 72, null, new Rectangle(0, 0, FlxG.width, 72)));
			back.add(select);
			back.add(layerPanel);
			back.add(tools);
			
			addTool = new Add(layerPanel, layers, select);
		}
		
		if (!opened)
		{
			var prevPath:String = Cookies.get("prevProject");
			if (Cookies.isValidPath(prevPath))
			{
				openProject(prevPath);
			}
			
			opened = true;
		}
	}
	
	private function openProject(P:String = null):Void
	{
		Reg.project = null;
		if (P == null)
			P = Base.openProject();
		Cookies.set("prevProject", P);
		var newState:EditProject = new EditProject(P, true);
		FlxG.switchState(newState);
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
			openProject();
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
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (Reg.project != null)
		{
			addTool.update();
		}
	}
}