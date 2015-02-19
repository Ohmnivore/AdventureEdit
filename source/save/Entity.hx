package save;
import ext.OrderedMap;
import haxe.xml.Fast;

/**
 * ...
 * @author Ohmnivore
 */
class Entity
{
	public var name:String = "newEnt";
	public var width:String = "16";
	public var height:String = "16";
	public var limit:String = "-1";
	public var color:String = "0xff0000";
	public var props:OrderedMap<String, String>;

	public function new() 
	{
		props = new OrderedMap<String, String>(new Map<String, String>());
	}
	
	public function parseXML(X:Xml):Void
	{
		name = X.get("name");
		width = X.get("width");
		height = X.get("height");
		limit = X.get("limit");
		color = X.get("color");
		
		for (sub in X.iterator())
		{
			props.set(sub.nodeName, sub.get("default"));
		}
	}
	
	public function getXML():Xml
	{
		var xml:Xml = Xml.createElement("entity");
		xml.set("name", name);
		xml.set("width", width);
		xml.set("height", height);
		xml.set("limit", limit);
		xml.set("color", color);
		
		for (p in props.keys())
		{
			var sub:Xml = Xml.createElement(p);
			sub.set("default", props.get(p));
			
			xml.addChild(sub);
		}
		
		return xml;
	}
}