package states;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.FlxG;
import save.Project;
import sys.io.File;
import ui.*;

/**
 * ...
 * @author Ohmnivore
 */
class EditProject extends FlxUIState
{
	private var path:String;
	private var autoClose:Bool;
	
	private var btnApply:FlxUIButton;
	private var btnCancel:FlxUIButton;
	
	private var pName:FlxUIInputText;
	private var pBgColor:FlxUIInputText;
	private var pGridColor:FlxUIInputText;
	private var pLevelValues:ValueList;
	private var pLayers:SimpleList;
	private var pEntities:EntList;
	
	public function new(Path:String, AutoClose:Bool = false)
	{
		super();
		
		path = Path;
		autoClose = AutoClose;
		var content:String = File.getContent(path);
		if (StringTools.trim(content) == "")
			content = null;
		
		Reg.project = new Project(path, content);
	}
	
	override public function create():Void 
	{
		_xml_id = "editProj";
		super.create();
		
		btnApply = new FlxUIButton(10, 10, "Apply", apply);
		add(btnApply);
		btnCancel = new FlxUIButton(FlxG.width - 90, 10, "Cancel", cancel);
		add(btnCancel);
		
		pLevelValues = new ValueList(10, 200, "Level values");
		pLayers = new SimpleList(10, 10);
		pEntities = new EntList(10, 10);
		
		var tabs:FlxUITabMenu = cast _ui.getAsset("tabs");
		var settings:FlxUIGroup = tabs.getTabGroup("settings");
		var layers:FlxUIGroup = tabs.getTabGroup("layers");
		var entities:FlxUIGroup = tabs.getTabGroup("entities");
		tabs.showTabId("settings");
		settings.add(pLevelValues);
		layers.add(pLayers);
		entities.add(pEntities);
		
		pName = cast getWidget(settings, "name");
		pBgColor = cast getWidget(settings, "bgcolor");
		pGridColor = cast getWidget(settings, "gridcolor");
		
		loadProject();
		
		if (autoClose)
		{
			apply();
			FlxG.switchState(new Main());
		}
	}
	
	private function loadProject():Void
	{
		var p:Project = Reg.project;
		
		pName.text = p.name;
		pBgColor.text = p.bgColor;
		pGridColor.text = p.gridColor;
		
		for (l in p.levelValues.keys())
		{
			pLevelValues.addNew(l, p.levelValues.get(l));
		}
		
		for (layer in p.layers)
		{
			pLayers.addNew(layer);
		}
	}
	
	private function getWidget(G:FlxUIGroup, ID:String):IFlxUIWidget
	{
		var ret:IFlxUIWidget = null;
		
		for (w in G.members)
		{
			var widget:IFlxUIWidget = cast w;
			
			if (ID == widget.name)
				ret = widget;
		}
		
		return ret;
	}
	
	private function apply():Void
	{
		var p:Project = Reg.project;
		
		p.name = pName.text;
		p.bgColor = pBgColor.text;
		p.gridColor = pGridColor.text;
		
		for (value in pLevelValues.list.members)
		{
			var vName:String = cast(value, FlxUIButton).label.text;
			
			p.levelValues.set(vName, pLevelValues.defs.get(vName));
		}
		
		for (layer in pLayers.list.members)
		{
			
			p.layers.push(cast(layer, FlxUIButton).label.text);
		}
		
		//TODO: entities
		
		var toSave:Xml = p.getXML();
		trace(toSave);
		File.saveContent(path, toSave.toString());
		FlxG.switchState(new Main());
	}
	
	private function cancel():Void
	{
		FlxG.switchState(new Main());
	}
}