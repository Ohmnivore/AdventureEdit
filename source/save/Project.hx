package save;
import haxe.xml.Fast;

/**
 * ...
 * @author Ohmnivore
 */
class Project
{
	public var path:String;
	
	public var name:String = "New Project";
	public var bgColor:String = "0x7DA0FF";
	public var gridColor:String = "0xFFF05A";
	public var levelValues:Map<String, String>;
	
	public var layers:Array<String> = [];
	
	public var entities:Array<Entity> = [];
	
	public function new(Path:String, XML:String = null) 
	{
		path = Path;
		
		levelValues = new Map<String, String>();
		
		if (XML != null && StringTools.trim(XML) != "")
		{
			var x:Fast = new Fast(Xml.parse(XML).firstElement());
			
			name = x.att.name;
			bgColor = x.att.bgColor;
			gridColor = x.att.gridColor;
			
			for (v in x.node.levelValues.elements)
			{
				levelValues.set(v.name, v.att.defaultValue);
			}
			
			for (l in x.node.layers.elements)
			{
				layers.push(l.name);
			}
			
			//TODO: Entities
		}
	}
	
	public function getXML():Xml
	{
		var xml:Xml = Xml.createElement("project");
		xml.set("name", name);
		xml.set("bgColor", bgColor);
		xml.set("gridColor", gridColor);
		
		var lvlValues:Xml = Xml.createElement("levelValues");
		xml.addChild(lvlValues);
		for (v in levelValues.keys())
		{
			var value:Xml = Xml.createElement(v);
			value.set("defaultValue", levelValues.get(v));
			
			lvlValues.addChild(value);
		}
		
		var layersData:Xml = Xml.createElement("layers");
		xml.addChild(layersData);
		for (l in layers)
		{
			layersData.addChild(Xml.createElement(l));
		}
		
		//TODO: Entities
		
		return xml;
	}
}