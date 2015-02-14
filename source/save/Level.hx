package save;
import ui.edit.EditImg;
import ui.LayerGroup;
import haxe.xml.Fast;

/**
 * ...
 * @author Ohmnivore
 */
class Level
{
	public var path:String;
	public var values:Map<String, String>;
	
	private var layers:LayerGroup;
	private var project:Project;
	
	public function new(Layers:LayerGroup, P:Project, Path:String, XML:String = null)
	{
		layers = Layers;
		project = P;
		path = Path;
		
		values = new Map<String, String>();
		
		for (v in project.levelValues.keys())
		{
			values.set(v, project.levelValues.get(v));
		}
		
		if (XML != null && StringTools.trim(XML) != "")
		{
			var xx:Xml = Xml.parse(XML).firstElement();
			var x:Fast = new Fast(xx);
			
			for (v in xx.attributes())
			{
				values.set(v, xx.get(v));
			}
			
			for (l in x.elements)
			{
				var layer:ShyGroup = layers.get(l.name);
				
				for (s in l.elements)
				{
					if (s.name == "img" && layer != null)
					{
						layer.add(new EditImg(Std.parseFloat(s.att.x), Std.parseFloat(s.att.y),
							s.att.path));
					}
				}
			}
		}
	}
	
	public function getXML():Xml
	{
		var xml:Xml = Xml.createElement("level");
		
		for (v in values.keys())
		{
			xml.set(v, values.get(v));
		}
		
		for (l in project.layers)
		{
			var layerData:Xml = Xml.createElement(l);
			xml.addChild(layerData);
			
			for (s in layers.get(l).members)
			{
				if (Std.is(s, EditImg))
				{
					var img:EditImg = cast s;
					var sData:Xml = Xml.createElement("img");
					sData.set("x", cast s.x);
					sData.set("y", cast s.y);
					sData.set("path", img.path);
					
					layerData.addChild(sData);
				}
			}
		}
		
		//TODO: Entities
		
		return xml;
	}
	
	public function reset():Void
	{
		values = new Map<String, String>();
	}
}