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
		var draw = newKey(key);
		sprite.makeGraphic(width, height, 0x0, false, key);
		
		if (draw)
			sprite.drawRoundRect(-height, 0, width + height, height, height, height, Game.color.transWhite);
	}
	
	public function drawRoundRect(sprite:FlxSprite, width:Int = 300, height:Int = 30) {
		var key = 'rr${width}x${height}';
		var draw = newKey(key);
		sprite.makeGraphic(width, height, 0x0, false, key);
		
		if (draw)
			sprite.drawRoundRect(0, 0, width, height, height, height, Game.color.transWhite);
	}
	
	public function drawArrow(sprite:FlxSprite, size:Int = 20) {
		var key = 'arrow$size';
		var draw = newKey(key);
		
		sprite.makeGraphic(size, size, 0x0, false, key);
		
		if (draw)
			sprite.drawTriangle(0, 0, size, Game.color.white);
	}
	
	public function drawUnitRoundRect(sprite:FlxSprite, unitWidth:Float, unitHeight:Float, ellipseUnitSize:Float = 1) {
		var width = Game.unitLength(unitWidth);
		var height = Game.unitLength(unitHeight);
		var ellipseSize = Game.unitLength(ellipseUnitSize);
		
		var key = 'urr${width}x${height}es$ellipseSize';
		var draw = newKey(key);
		
		sprite.makeGraphic(width, height, 0x0, false, key);
		if (draw)
			sprite.drawRoundRect(0, 0, width, height, ellipseSize, ellipseSize, Game.color.white);
	}
	
	public function drawPaddle(paddle:Paddle) {
		if (paddle.movesHorizontally())
			paddle.setSize(paddle.length, Game.unitLength(1.5));
		else paddle.setSize(Game.unitLength(1.5), paddle.length);
		
		var unitWidth:Float = paddle.width / Game.unitLength();
		var unitHeight:Float = paddle.height / Game.unitLength();
		drawUnitRoundRect(paddle, unitWidth, unitHeight, 1.5);
	}
	
	public function drawWall(wall:Wall) {
		var unitWidth:Int = cast wall.width / Game.unitLength();
		var unitHeight:Int = cast wall.height / Game.unitLength();
		drawUnitRoundRect(wall, unitWidth, unitHeight);
	}
	
	public function drawEyeWhite(sprite:FlxSprite) {
		var diameter = 18;
		var radius = diameter / 2;
		var key = "eyewhite";
		var draw = newKey(key);
		
		sprite.makeGraphic(diameter, diameter, 0x0, false, key);
		if (draw)
			sprite.drawCircle(-1, -1, radius, Game.color.white);
	}
	
	public function drawPupil(sprite:FlxSprite) {
		var diameter = 9;
		var radius = diameter / 2;
		var key = "pupil";
		var draw = newKey(key);
		
		sprite.makeGraphic(diameter, diameter, 0x0, false, key);
		if (draw)
			sprite.drawCircle(-1, -1, radius, Game.color.white);
	}
	
	private inline function newKey(key:String):Bool {
		return !FlxG.bitmap.checkCache(key);
	}
	
}