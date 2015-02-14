package file;
import flash.display.BitmapData;
import openfl.display.Loader;
import openfl.display.LoaderInfo;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.addons.display.FlxGridOverlay;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import haxe.io.Bytes;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.display.Loader;

import sys.io.File;
import systools.Dialogs;

/**
 * ...
 * @author Ohmnivore
 */
class ImageHandler
{
	public var s:FlxSprite;
	public var callback:FlxSprite->Void;
	
	public function new(P:String, S:FlxSprite, Callback:FlxSprite->Void = null)
	{
		s = S;
		callback = Callback;
		
		var l:Loader = new Loader();
		l.contentLoaderInfo.addEventListener(Event.COMPLETE, loadBytesHandler);
		l.load(new URLRequest(P));
	}
	
	private function loadBytesHandler(event:Event):Void
	{
		var loaderInfo:LoaderInfo = cast(event.target, LoaderInfo);
		loaderToFlxSprite(loaderInfo, s);
	}
	
	public function loaderToFlxSprite(L:LoaderInfo, S:FlxSprite):Void
	{
		S.makeGraphic(Std.int(L.content.width), Std.int(L.content.height), 0xffffffff, true);
		var temp:BitmapData = S.pixels;
		temp.draw(L.content);
		
		if (callback != null)
			callback(S);
	}
}