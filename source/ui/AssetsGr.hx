package ui;
import flash.geom.Rectangle;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIAssets;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIDropDownMenu.FlxUIDropDownHeader;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.FlxUISpriteButton;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.FlxUITypedButton.FlxUITypedButton;
import flixel.addons.ui.interfaces.IFlxUIButton;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxStringUtil;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class AssetsGr
{
	static public var CHROME:String = "assets/gfx/chrome.png";
	static public var BUTTON:String = "assets/gfx/button.png";
	static public var BUTTON_THIN:String = "assets/gfx/button_thin.png";
	static public var TAB:String = "assets/gfx/tab.png";
	static public var TAB_BACK:String = "assets/gfx/tab_back.png";
	static public var LIST_RIGHT:String = "assets/gfx/button_arrow_right.png";
	static public var LIST_LEFT:String = "assets/gfx/button_arrow_left.png";
	static public var LIST_UP:String = "assets/gfx/button_arrow_up.png";
	static public var LIST_DOWN:String = "assets/gfx/button_arrow_down.png";
	
	static public function setBtnGraphic(Btn:FlxUIButton):Void
	{
		Btn.loadGraphicSlice9([AssetsGr.BUTTON], 80, 20, []);
		Btn.resize(80, 20);
		Btn.label.color = 0xffffffff;
		Btn.over_color = 0xffffffff;
		Btn.down_color = 0xffffffff;
		Btn.up_color = 0xffffffff;
		//Btn.label.setBorderStyle(FlxText.BORDER_OUTLINE);
		Btn.label.setBorderStyle(FlxTextBorderStyle.OUTLINE);
		Btn.label.borderColor = 0xff000000;
	}
	
	static public function setTextStyle(T:FlxText):Void
	{
		T.color = 0xffffffff;
		//T.setBorderStyle(FlxText.BORDER_OUTLINE);
		T.setBorderStyle(FlxTextBorderStyle.OUTLINE);
		T.borderColor = 0xff000000;
	}
	
	static public function setHeaderStyle(H:FlxUIDropDownHeader):Void
	{
		var btn:FlxUISpriteButton = H.button;
		btn.loadGraphicsUpOverDown(AssetsGr.BUTTON_THIN);
		btn.x += 1;
		btn.y += 1;
		
		btn.width = H.width;
	}
	
	static public function getStepperPlus():FlxUITypedButton<FlxSprite>
	{
		var ButtonPlus:FlxUITypedButton<FlxSprite> = new FlxUITypedButton<FlxSprite>(0, 0);
		ButtonPlus.loadGraphicSlice9([AssetsGr.BUTTON_THIN], 21, 21, [FlxStringUtil.toIntArray(FlxUIAssets.SLICE9_BUTTON_THIN)], FlxUI9SliceSprite.TILE_NONE, -1, false, FlxUIAssets.IMG_BUTTON_SIZE, FlxUIAssets.IMG_BUTTON_SIZE);
		ButtonPlus.label = new FlxSprite(0, 0, FlxUIAssets.IMG_PLUS);
		
		return ButtonPlus;
	}
	
	static public function getStepperMinus():FlxUITypedButton<FlxSprite>
	{
		var ButtonPlus:FlxUITypedButton<FlxSprite> = new FlxUITypedButton<FlxSprite>(0, 0);
		ButtonPlus.loadGraphicSlice9([AssetsGr.BUTTON_THIN], 21, 21, [FlxStringUtil.toIntArray(FlxUIAssets.SLICE9_BUTTON_THIN)], FlxUI9SliceSprite.TILE_NONE, -1, false, FlxUIAssets.IMG_BUTTON_SIZE, FlxUIAssets.IMG_BUTTON_SIZE);
		ButtonPlus.label = new FlxSprite(0, 0, FlxUIAssets.IMG_MINUS);
		
		return ButtonPlus;
	}
	
	static public function getTabBackground():FlxUI9SliceSprite
	{
		return new FlxUI9SliceSprite(0, 0, AssetsGr.CHROME, new Rectangle(0, 0, 200, 200));
	}
	
	static public function getTab(Name:String):FlxUIButton
	{
		var fb:FlxUIButton = new FlxUIButton(0, 0, Name);
		
		//default style:
		fb.up_color = 0xffffff;
		fb.down_color = 0xffffff;
		fb.over_color = 0xffffff;
		fb.up_toggle_color = 0xffffff;
		fb.down_toggle_color = 0xffffff;
		fb.over_toggle_color = 0xffffff;
		
		fb.label.color = 0xFFFFFF;
		//fb.label.setBorderStyle(FlxText.BORDER_OUTLINE);
		fb.label.setBorderStyle(FlxTextBorderStyle.OUTLINE);
		
		//fb.id = Name;
		fb.name = Name;
		
		//load default graphics
		var graphic_ids:Array<String> = [AssetsGr.TAB_BACK, AssetsGr.TAB_BACK, AssetsGr.TAB_BACK, AssetsGr.TAB, AssetsGr.TAB, AssetsGr.TAB];
		
		//var graphic_ids:Array<FlxGraphicAsset> = [FlxGraphicAsset];
		
		var slice9tab:Array<Int> = FlxStringUtil.toIntArray(FlxUIAssets.SLICE9_TAB);
		var slice9_ids:Array<Array<Int>> = [slice9tab, slice9tab, slice9tab, slice9tab, slice9tab, slice9tab];
		fb.loadGraphicSlice9(cast graphic_ids, 0, 0, slice9_ids, FlxUI9SliceSprite.TILE_NONE, -1, true);
		
		return fb;
	}
	
	static public function setListStyle(L:FlxUIList):Void
	{
		if (L.stacking == FlxUIList.STACK_HORIZONTAL)
		{
			L.nextButton.loadGraphicsUpOverDown(AssetsGr.LIST_RIGHT);
			L.prevButton.loadGraphicsUpOverDown(AssetsGr.LIST_LEFT);
		}
		else
		{
			L.nextButton.loadGraphicsUpOverDown(AssetsGr.LIST_DOWN);
			L.prevButton.loadGraphicsUpOverDown(AssetsGr.LIST_UP);
		}
		
		setBtnLabelStyle(cast L.nextButton);
		setBtnLabelStyle(cast L.prevButton);
	}
	
	static private function setBtnLabelStyle(Btn:FlxUIButton):Void
	{
		Btn.label.color = 0xffffffff;
		Btn.over_color = 0xffffffff;
		Btn.down_color = 0xffffffff;
		Btn.up_color = 0xffffffff;
		//Btn.label.setBorderStyle(FlxText.BORDER_OUTLINE);
		Btn.label.setBorderStyle(FlxTextBorderStyle.OUTLINE);
		Btn.label.borderColor = 0xff000000;
	}
}