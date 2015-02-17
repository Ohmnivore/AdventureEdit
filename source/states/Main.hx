package states;
import ext.MyCam;
import file.Base;
import flixel.addons.display.FlxZoomCamera;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUITabMenu;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxSpriteUtil;
import haxe.Constraints.Function;
import haxe.io.Path;
import lime.app.Config;
import openfl.geom.Rectangle;
import save.Cookies;
import save.Level;
import sys.io.File;
import ui.AssetsGr;
import ui.edit.EditImg;
import ui.EntList;
import ui.InfiniteGrid;
import ui.LayerGroup;
import ui.panels.LayerPanel;
import ui.panels.ToolPanel;
import ui.select.List;
import ui.SimpleList;
import ui.StatusBar;
import ui.tools.Camera;
import ui.tools.Move;
import ui.tools.Remove;
import ui.tools.Select;
import ui.tools.Shortcut;
import ui.tools.Tool;
import ui.tools.Zoom;
import ui.ValueList;
import ui.tools.Add;
import flixel.addons.display.FlxGridOverlay;

/**
 * ...
 * @author Ohmnivore
 */
class Main extends FlxUIState
{
	public var back:FlxUIGroup;
	private var menuProj:FlxUIDropDownMenu;
	
	public var select:List;
	private var layers:LayerGroup;
	private var layerPanel:LayerPanel;
	private var tools:ToolPanel;
	private var status:StatusBar;
	
	private var shortcut:Shortcut;
	private var currentTool:Tool;
	private var currentToolName:String;
	private var addTool:Add;
	private var removeTool:Remove;
	private var selectTool:Select;
	private var moveTool:Move;
	private var cameraTool:Camera;
	private var zoomTool:Zoom;
	private var doEdit:Bool = true;
	
	private var grid:InfiniteGrid;
	private var background:ShyGroup;
	
	private var backCam:FlxZoomCamera;
	
	private static var opened:Bool = false;
	private static var lvlOpened:Bool = false;
	
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
		
		//backCam = new FlxCamera();
		backCam = new MyCam(0, 0, FlxG.width, FlxG.height, 1);
		Reg.backCam = backCam;
		//backCam.bgColor = 0x00000000;
		backCam.bgColor = 0xff2B363B;
		
		FlxG.cameras.reset(backCam);
		var topCam:FlxCamera = new FlxCamera();
		topCam.bgColor = 0x00000000;
		FlxG.cameras.add(topCam);
		FlxG.camera = topCam;
		
		var menuGen:FlxUIDropDownMenu = cast _ui.getAsset("general");
		menuGen.callback = handleGeneral;
		AssetsGr.setHeaderStyle(menuGen.header);
		menuProj = cast _ui.getAsset("project");
		menuProj.callback = handleProject;
		AssetsGr.setHeaderStyle(menuProj.header);
		var menuLvl:FlxUIDropDownMenu = cast _ui.getAsset("level");
		menuLvl.callback = handleLvl;
		AssetsGr.setHeaderStyle(menuLvl.header);
		var menuEdit:FlxUIDropDownMenu = cast _ui.getAsset("edit");
		menuEdit.callback = handleEdit;
		AssetsGr.setHeaderStyle(menuEdit.header);
		var menuView:FlxUIDropDownMenu = cast _ui.getAsset("view");
		menuView.callback = handleView;
		AssetsGr.setHeaderStyle(menuView.header);
		back = _ui.getGroup("background");
		background = new ShyGroup();
		back.add(background);
		
		if (Reg.project != null)
		{
			//FlxG.camera.bgColor = Std.parseInt(Reg.project.bgColor) + 0xff000000;
			
			layers = new LayerGroup(Reg.project.layers);
			select = new List(0, FlxG.height - 68, FlxG.width);
			layerPanel = new LayerPanel(4, 32, Reg.project.layers);
			tools = new ToolPanel(FlxG.width - 92, 32);
			status = new StatusBar(6);
			add(status);
			status.projectName = Reg.project.name;
			
			back.add(layers);
			back.add(new FlxUI9SliceSprite(0, FlxG.height - 72, AssetsGr.CHROME,
				new Rectangle(0, 0, FlxG.width, 72)));
			back.add(select);
			back.add(layerPanel);
			back.add(tools);
			
			if (Reg.level == null)
			{
				if (!lvlOpened)
				{
					var prevLvlPath:String = Cookies.get("prevLevel");
					if (Cookies.isValidPath(prevLvlPath))
					{
						lvlPath = prevLvlPath;
					}
					lvlOpened = true;
				}
				
				var content:String = null;
				if (lvlPath != null)
				{
					content = File.getContent(lvlPath);
					if (StringTools.trim(content) == "")
						content = null;
				}
				Reg.level = new Level(layers, Reg.project, lvlPath, content);
				setStatusLvl();
				setLevelSize();
			}
			
			shortcut = new Shortcut(this, tools);
			addTool = new Add(layerPanel, layers, select);
			removeTool = new Remove(layers, layerPanel);
			selectTool = new Select(layers, layerPanel, this);
			moveTool = new Move();
			cameraTool = new Camera();
			zoomTool = new Zoom(this);
			
			_ui.scrollFactor.set();
			back.scrollFactor.set();
			layers.scrollFactor.set(1.0, 1.0);
			menuProj.scrollFactor.set();
			select.scrollFactor.set();
			layerPanel.scrollFactor.set();
			tools.scrollFactor.set();
			status.scrollFactor.set();
			background.scrollFactor.set(1.0, 1.0);
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
		
		_ui.cameras = [FlxG.camera];
		if (status != null)
			status.cameras = [FlxG.camera];
		if (grid != null)
		{
			background.cameras = [Reg.backCam];
			grid.cameras = [Reg.backCam];
		}
		
		if (Reg.project == null)
		{
			menuLvl.visible = false;
			menuLvl.active = false;
			
			menuEdit.visible = false;
			menuEdit.active = false;
			
			menuView.visible = false;
			menuView.active = false;
		}
		if (Reg.level == null)
		{
			menuEdit.visible = false;
			menuEdit.active = false;
			
			menuView.visible = false;
			menuView.active = false;
		}
	}
	
	public function setLevelSize():Void
	{
		if (grid != null)
		{
			layers.cursorGroup.remove(grid, true);
			grid.kill();
			grid.destroy();
		}
		grid = new InfiniteGrid(64, Reg.level.width, Reg.level.height);
		layers.cursorGroup.add(grid);
		FlxSpriteUtil.screenCenter(grid);
		
		background.clear();
		var b:FlxSprite = new FlxSprite();
		b.makeGraphic(Reg.level.width, Reg.level.height, Std.parseInt(Reg.project.bgColor) + 0xff000000, true);
		background.add(b);
		FlxSpriteUtil.screenCenter(b);
		
		grid.cameras = [backCam];
		b.cameras = [backCam];
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
	
	private function setStatusLvl():Void
	{
		if (Reg.level.path == null)
			status.lvlName = "UnnamedLvl";
		else
		{
			status.lvlName = Path.withoutDirectory(Reg.level.path);
		}
	}
	
	public function handleGeneral(ID:String):Void
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
	
	private function isUnsaved():Bool
	{
		if (Reg.level != null)
		{
			if (!Reg.level.saved)
				return true;
		}
		
		return false;
	}
	
	public function handleProject(ID:String):Void
	{
		if (ID == "newproj")
		{
			if (isUnsaved())
				openSubState(new Confirm(newProject));
			else
				newProject();
		}
		else if (ID == "openproj")
		{
			if (isUnsaved())
				openSubState(new Confirm(cast openProject));
			else
				openProject();
		}
		else if (ID == "editproj" && Reg.project != null)
		{
			if (isUnsaved())
				openSubState(new Confirm(editProject));
			else
				editProject();
		}
		else if (ID == "closeproj")
		{
			if (isUnsaved())
			{
				openSubState(new Confirm(closeProject));
			}
			else
			{
				closeProject();
			}
		}
	}
	
	private function newProject():Void
	{
		Reg.project = null;
		FlxG.switchState(new EditProject(Base.newProject()));
	}
	
	private function editProject():Void
	{
		FlxG.switchState(new EditProject(Reg.project.path));
	}
	
	private function closeProject():Void
	{
		Reg.project = null;
		closeLvl();
	}
	
	public function handleLvl(ID:String):Void
	{
		if (Reg.project != null && Reg.level != null)
		{
			if (ID == "lvlprop")
			{
				openSubState(new EditValues(this));
			}
			else if (ID == "newlvl")
			{
				if (isUnsaved())
					openSubState(new Confirm(newLvl));
				else
					newLvl();
			}
			else if (ID == "openlvl")
			{
				if (isUnsaved())
					openSubState(new Confirm(openLvl));
				else
					openLvl();
			}
			else if (ID == "savelvl")
			{
				if (Reg.level.path != null)
				{
					File.saveContent(Reg.level.path, Reg.level.getXML().toString());
					Reg.level.saved = true;
				}
			}
			else if (ID == "savelvlas")
			{
				Reg.level.path = Base.saveFile();
				File.saveContent(Reg.level.path, Reg.level.getXML().toString());
				Reg.level.saved = true;
			}
			else if (ID == "closelvl")
			{
				if (isUnsaved())
					openSubState(new Confirm(closeLvl));
				else
					closeLvl();
			}
		}
	}
	
	private function closeLvl():Void
	{
		Reg.level = null;
		FlxG.switchState(new Main());
	}
	
	private function openLvl():Void
	{
		Reg.level = null;
		var path:String = Base.openFile();
		Cookies.set("prevLevel", path);
		FlxG.switchState(new Main(path));
	}
	
	private function newLvl():Void
	{
		Reg.level = null;
		FlxG.switchState(new Main(Base.newFile()));
	}
	
	public function centerView():Void
	{
		Reg.backCam.scroll.x = grid.x + grid.width / 2.0 - Reg.backCam.width / 2.0;
		Reg.backCam.scroll.y = grid.y + grid.height / 2.0 - Reg.backCam.height / 2.0;
	}
	
	public function handleEdit(ID:String):Void
	{
		if (Reg.level != null)
		{
			if (ID == "cut")
			{
				for (s in Reg.selected)
				{
					s.kill();
					s.destroy();
				}
				Reg.selected = [];
				
				Reg.level.saved = false;
			}
			else if (ID == "selectall")
			{
				for (g in layers.editGroups.members)
				{
					var group:ShyGroup = cast g;
					for (s in group.members)
					{
						var img:EditImg = cast s;
						img.selected = true;
						Reg.selected.push(img);
					}
				}
			}
			else if (ID == "deselect")
			{
				for (s in Reg.selected)
				{
					s.selected = false;
				}
				Reg.selected = [];
			}
		}
	}
	
	public function handleView(ID:String):Void
	{
		if (Reg.level != null)
		{
			if (ID == "centerview")
			{
				centerView();
			}
			else if (ID == "grid")
			{
				grid.visible = !grid.visible;
			}
			else if (ID == "zoomin")
			{
				zoomTool.zoomIn();
			}
			else if (ID == "zoomout")
			{
				zoomTool.zoomOut();
			}
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (Reg.project != null && Reg.level != null)
		{
		layers.cameras = [Reg.backCam];
		shortcut.update();
		
		if (Reg.project != null && Reg.level != null && doEdit && FlxG.mouse.screenY < FlxG.height - 72)
		{
			cameraTool.update();
			if (currentTool != null)
				currentTool.update();
			
			if (tools.currentTool != currentToolName)
			{
				currentToolName = tools.currentTool;
				
				hideTools();
				
				if (currentToolName == "Add")
					currentTool = addTool;
				else if (currentToolName == "Remove")
					currentTool = removeTool;
				else if (currentToolName == "Select")
					currentTool = selectTool;
				else if (currentToolName == "Move")
					currentTool = moveTool;
				
				currentTool.opened = true;
			}
		}
		
		doEdit = true;
		}
	}
	
	private function hideTools():Void
	{
		addTool.opened = false;
		removeTool.opened = false;
		selectTool.opened = false;
		moveTool.opened = false;
	}
}