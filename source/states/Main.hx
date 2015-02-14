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
import save.Level;
import sys.io.File;
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
	private var doEdit:Bool = true;
	
	private static var opened:Bool = false;
	
	private var lvlPath:String;
	
	public function new(LvlPath:String = null)
	{
		super();
		
		lvlPath = LvlPath;
	}
	
	override public function getEvent(id:String, sender:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Void 
	{
		super.getEvent(id, sender, data, params);
		
		if (id == "click_button" || id == "click_dropdown")
		{
			doEdit = false;
		}
	}
	
	override public function create():Void 
	{
		_xml_id = "main";
		super.create();
		
		var menuGen:FlxUIDropDownMenu = cast _ui.getAsset("general");
		menuGen.callback = handleGeneral;
		menuProj = cast _ui.getAsset("project");
		menuProj.callback = handleProject;
		var menuLvl:FlxUIDropDownMenu = cast _ui.getAsset("level");
		menuLvl.callback = handleLvl;
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
			
			if (Reg.level == null)
			{
				var content:String = null;
				if (lvlPath != null)
				{
					content = File.getContent(lvlPath);
					if (StringTools.trim(content) == "")
						content = null;
				}
				
				Reg.level = new Level(layers, Reg.project, lvlPath, content);
			}
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
	
	private function handleGeneral(ID:String):Void
	{
		if (ID == "abouthelp")
		{
			FlxG.openURL("https://github.com/Ohmnivore/AdventureEdit");
		}
		else if (ID == "exit")
		{
			Sys.exit(0);
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
	
	private function handleLvl(ID:String):Void
	{
		if (Reg.project != null && Reg.level != null)
		{
			if (ID == "lvlprop")
			{
				
			}
			else if (ID == "newlvl")
			{
				Reg.level = null;
				FlxG.switchState(new Main(Base.newFile()));
			}
			else if (ID == "openlvl")
			{
				Reg.level = null;
				var path:String = Base.openFile();
				FlxG.switchState(new Main(path));
			}
			else if (ID == "savelvl")
			{
				trace(Reg.level.path);
				if (Reg.level.path != null)
					File.saveContent(Reg.level.path, Reg.level.getXML().toString());
			}
			else if (ID == "savelvlas")
			{
				Reg.level.path = Base.saveFile();
				File.saveContent(Reg.level.path, Reg.level.getXML().toString());
			}
			else if (ID == "closelvl")
			{
				Reg.level = null;
				FlxG.switchState(new Main());
			}
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (Reg.project != null && doEdit && FlxG.mouse.screenY < FlxG.height - 72)
		{
			addTool.update();
		}
		
		doEdit = true;
	}
}