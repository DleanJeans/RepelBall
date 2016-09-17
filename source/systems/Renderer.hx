package systems;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
using flixel.util.FlxSpriteUtil;

class Renderer {
	public function new() {}
	
	public function drawBall(ball:Ball) {
		var diameter = Game.unitLength();
		var radius = diameter / 2;
		var key = 'ball$diameter';
		var draw = newKey(key);
		
		ball.makeGraphic(diameter, diameter, 0x0, false, key);
		if (draw)
			ball.drawCircle(-1, -1, radius, Game.color.white);
	}
	
	public function drawPaddle(paddle:Paddle) {
		if (paddle.movesHorizontally())
			paddle.setSize(paddle.length, Game.unitLength());
		else paddle.setSize(Game.unitLength(), paddle.length);
		
		drawRoundRect(paddle, cast paddle.width, cast paddle.height, Game.unitLength());
	}
	
	public function drawWall(wall:Wall) {
		drawRoundRect(wall, cast wall.width, cast wall.height, 0);
	}
	
	public function drawEyeWhite(sprite:FlxSprite) {
		var diameter = Game.unitLength(0.8);
		var radius = diameter / 2;
		var key = "eyewhite";
		var draw = newKey(key);
		
		sprite.makeGraphic(diameter, diameter, 0x0, false, key);
		if (draw)
			sprite.drawCircle(-1, -1, radius, Game.color.white);
	}
	
	public function drawPupil(sprite:FlxSprite) {
		var diameter = Game.unitLength(0.4);
		var radius = diameter / 2;
		var key = "pupil";
		var draw = newKey(key);
		
		sprite.makeGraphic(diameter, diameter, 0x0, false, key);
		if (draw)
			sprite.drawCircle(-1, -1, radius, Game.color.white);
	}
	
	public function drawSideButton(sprite:FlxSprite, width:Int = 200, height:Int = 50) {
		var key = 'sb${width}x${height}';
		var draw = newKey(key);
		sprite.makeGraphic(width, height, 0x0, false, key);
		
		if (draw)
			sprite.drawRoundRect(-height, 0, width + height, height, height, height, Game.color.transWhite);
	}
	
	public function drawRoundRect(sprite:FlxSprite, width:Int = 300, height:Int = 30, ellipseSize:Int, color:FlxColor = Game.color.white) {
		var key = 'rr${width}x${height}es${ellipseSize}c${color.toHexString()}';
		var draw = newKey(key);
		sprite.makeGraphic(width, height, 0x0, false, key);
		
		if (draw)
			sprite.drawRoundRect(0, 0, width, height, ellipseSize, ellipseSize, color);
	}
	
	public function drawArrow(sprite:FlxSprite, size:Int = 20) {
		var key = 'arrow$size';
		var draw = newKey(key);
		
		sprite.makeGraphic(size, size, 0x0, false, key);
		
		if (draw)
			sprite.drawTriangle(0, 0, size, Game.color.white);
	}
	
	public inline function drawPaddleBack(paddleBack:FlxSprite) {
		paddleBack.makeGraphic(Game.settings.TEAM_SETTINGS_PADDLE_BACK_SIZE, Game.settings.TEAM_SETTINGS_PADDLE_BACK_SIZE);
	}
	
	private inline function newKey(key:String):Bool {
		return !FlxG.bitmap.checkCache(key);
	}
	
}