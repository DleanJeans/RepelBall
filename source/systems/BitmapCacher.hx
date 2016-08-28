package systems;

import flixel.FlxSprite;
using flixel.util.FlxSpriteUtil;

class BitmapCacher {
	private var keys:Array<String>;
	
	public function new() {
		keys = new Array<String>();
	}
	
	public function drawSideButton(sprite:FlxSprite, width:Int = 200, height:Int = 50) {
		var key = 'sb${width}x${height}';
		sprite.makeGraphic(width, height, 0x0, false, key);
		if (newKey(key)) {
			sprite.drawRoundRect(-height, 0, width + height, height, height, height, Game.colors.transWhite);
			addKey(key);
		}
	}
	
	public function drawRoundRect(sprite:FlxSprite, width:Int = 300, height:Int = 30) {
		var key = 'rr${width}x${height}';
		sprite.makeGraphic(width, height, 0x0, false, key);
		if (newKey(key)) {
			sprite.drawRoundRect(0, 0, width, height, height, height, Game.colors.transWhite);
			addKey(key);
		}
	}
	
	public function drawArrow(sprite:FlxSprite, size:Int = 20) {
		var key = 'arrow$size';
		sprite.makeGraphic(size, size, 0x0, false, key);
		if (newKey(key)) {
			sprite.drawTriangle(0, 0, size, Game.colors.white);
			addKey(key);
		}
	}
	
	private inline function newKey(key:String) {
		return keys.indexOf(key) == -1;
	}
	
	private inline function addKey(key:String) {
		keys.push(key);
	}
}