package ui.tools;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;

/**
 * ...
 * @author Ohmnivore
 */
class SelectRect extends FlxSprite
{
	public var startPoint:FlxPoint;
	public var endPoint:FlxPoint;
	public var fillColor:Int;
	private var rect:FlxRect;
	
	public function new(FillColor:Int)
	{
		super();
		
		startPoint = new FlxPoint();
		endPoint = new FlxPoint();
		rect = new FlxRect();
		fillColor = FillColor;
		
		alpha = 0.75;
	}
	
	private function setRect():Void
	{
		if (endPoint.x > startPoint.x)
			rect.x = startPoint.x;
		else
			rect.x = endPoint.x;
		
		if (endPoint.y > startPoint.y)
			rect.y = startPoint.y
		else
			rect.y = endPoint.y;
		
		rect.width = Math.abs(startPoint.x - endPoint.x);
		rect.height = Math.abs(startPoint.y - endPoint.y);
	}
	
	private function applyRect():Void
	{
		x = rect.x;
		y = rect.y;
		width = rect.width;
		height = rect.height;
		if (width == 0)
			width = 1;
		if (height == 0)
			height = 1;
	}
	
	private function drawRect():Void
	{
		makeGraphic(cast width, cast height, fillColor, true);
	}
	
	override public function update(elapsed:Float):Void 
	{
		setRect();
		applyRect();
		drawRect();
		
		super.update(elapsed);
	}
	
	override function set_visible(Value:Bool):Bool 
	{
		if (!visible && Value)
			makeGraphic(cast width, cast height, 0x00000000, true);
		
		return super.set_visible(Value);
	}
}