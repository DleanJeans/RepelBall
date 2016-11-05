package systems;

import flixel.FlxG;
import flixel.FlxSprite;

class Watermark {
	public var watermark(default, null):FlxSprite;
	
	public function new() {
		watermark = new FlxSprite(0, 0, Game.renderer.renderSvg(AssetPaths.Watermark__svg));
		watermark.visible = false;
		watermark.setPosition(5, Game.walls.bottomWall.y - watermark.height - 10);
		watermark.alpha = 0.5;
		
		Game.stage.addUI(watermark);
	}
	
	public inline function toggle() {
		watermark.visible = !watermark.visible;
	}
	
}