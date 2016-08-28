package systems.ui;

import flixel.ui.FlxButton;
import flixel.math.FlxPoint;
import flixel.text.FlxText.FlxTextAlign;
using flixel.util.FlxSpriteUtil;

class SideButton extends FlxButton {
	public function new(x:Float = 0, y:Float = 0, width:Int = 200, height:Int = 50, ?text:String, textSize:Int = 35, ?onClick:Void->Void) {
		super(x, y, text, onClick);
		
		Game.bitmapCacher.drawSideButton(this, width, height);
		changeLabelSettings(textSize);
	}
	
	private function drawButton(width:Int = 200, height:Int = 50) {
		makeGraphic(width, height, 0x0, true);
		FlxSpriteUtil.drawRoundRect(this, -height, 0, width + height, height, height, height, Game.colors.transWhite);
	}
	
	private function changeLabelSettings(textSize:Int) {
		label.setFormat(AssetPaths.SquareFont__ttf, textSize, Game.colors.white, FlxTextAlign.RIGHT);
		labelAlphas = [1, 1, 1];
		label.offset.set(height / 2);
		labelOffsets = [FlxPoint.get(0, 4), FlxPoint.get(0, 4), FlxPoint.get(0, 4)];
		status = FlxButton.NORMAL;
	}
	
	public inline function flip() {
		flipX = true;
		label.offset.scale(-1);
		label.alignment = label.alignment == FlxTextAlign.RIGHT ? FlxTextAlign.LEFT : FlxTextAlign.RIGHT;
	}
}