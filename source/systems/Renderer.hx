package systems;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import objects.Paddle;
import objects.Wall;
using flixel.util.FlxSpriteUtil;

class Renderer {
	public function new() {}
	
	public function drawSideButton(sprite:FlxSprite, width:Int = 200, height:Int = 50) {
		var key = 'sb${width}x${height}';
		var noGraphic = newKey(key);
		sprite.makeGraphic(width, height, 0x0, false, key);
		
		if (noGraphic)
			sprite.drawRoundRect(-height, 0, width + height, height, height, height, Game.color.transWhite);
	}
	
	public function drawRoundRect(sprite:FlxSprite, width:Int = 300, height:Int = 30) {
		var key = 'rr${width}x${height}';
		var noGraphic = newKey(key);
		sprite.makeGraphic(width, height, 0x0, false, key);
		
		if (noGraphic)
			sprite.drawRoundRect(0, 0, width, height, height, height, Game.color.transWhite);
	}
	
	public function drawArrow(sprite:FlxSprite, size:Int = 20) {
		var key = 'arrow$size';
		var noGraphic = newKey(key);
		
		sprite.makeGraphic(size, size, 0x0, false, key);
		
		if (noGraphic)
			sprite.drawTriangle(0, 0, size, Game.color.white);
	}
	
	public function drawUnitRoundRect(sprite:FlxSprite, unitWidth:Float, unitHeight:Float) {
		var width = Game.unitLength(unitWidth);
		var height = Game.unitLength(unitHeight);
		var ellipseSize = Game.unitLength();
		
		var key = 'urr${width}x${height}';
		var noGraphic = newKey(key);
		
		sprite.makeGraphic(width, height, 0x0, false, key);
		if (noGraphic)
			sprite.drawRoundRect(0, 0, width, height, ellipseSize, ellipseSize, Game.color.white);
	}
	
	public function drawPaddle(paddle:Paddle) {
		if (paddle.movesHorizontally())
			paddle.setSize(paddle.length, Game.unitLength());
		else paddle.setSize(Game.unitLength(), paddle.length);
		
		var unitWidth:Int = cast paddle.width / Game.unitLength();
		var unitHeight:Int = cast paddle.height / Game.unitLength();
		drawUnitRoundRect(paddle, unitWidth, unitHeight);
	}
	
	public function drawWall(wall:Wall) {
		var unitWidth:Int = cast wall.width / Game.unitLength();
		var unitHeight:Int = cast wall.height / Game.unitLength();
		drawUnitRoundRect(wall, unitWidth, unitHeight);
	}
	
	private inline function newKey(key:String):Bool {
		return !FlxG.bitmap.checkCache(key);
	}
	
}