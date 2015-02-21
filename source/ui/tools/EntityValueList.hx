package ui.tools;
import ui.edit.EditEnt;
import ui.SimpleValueList;

/**
 * ...
 * @author Ohmnivore
 */
class EntityValueList extends SimpleValueList
{
	public var ent:EditEnt;
	
	public function new(Ent:EditEnt, X:Float, Y:Float) 
	{
		super(X, Y);
		ent = Ent;
		
		for (p in ent.props.keys())
		{
			addNew(p, ent.props.get(p));
		}
	}
	
	override public function unToggle():Void 
	{
		super.unToggle();
		for (v in defs.keys())
		{
			ent.props.set(v, defs.get(v));
		}
	}
}