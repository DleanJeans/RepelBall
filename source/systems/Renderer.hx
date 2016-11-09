package systems;

import flash.display.BitmapData;
import flash.display.Shape;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import format.SVG;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
import openfl.Assets;
using flixel.util.FlxSpriteUtil;

class Renderer {
	private var _svgShape:Shape;
	
	public function new() {
		_svgShape = new Shape();
	}
	
	public function drawBall(ball:Ball) {
		var diameter = Settings.unitLength();
		var radius = diameter / 2;
		var key = 'ball$diameter';
		var draw = newKey(key);
		
		ball.makeGraphic(diameter, diameter, 0x0, false, key);
		if (draw)
			ball.drawCircle(-1, -1, radius, Game.color.white);
	}
	
	public function drawPaddle(paddle:Paddle) {
		if (paddle.movesHorizontally())
			paddle.setSize(paddle.length, Settings.unitLength());
		else paddle.setSize(Settings.unitLength(), paddle.length);
		
		drawRoundRect(paddle, cast paddle.width, cast paddle.height, Settings.unitLength());
	}
	
	public function drawWall(wall:Wall) {
		drawRoundRect(wall, cast wall.width, cast wall.height, 0);
	}
	
	public function drawEyeWhite(sprite:FlxSprite) {
		var diameter = Settings.unitLength(0.8);
		var radius = diameter / 2;
		var key = "eyewhite";
		var draw = newKey(key);
		
		sprite.makeGraphic(diameter, diameter, 0x0, false, key);
		if (draw)
			sprite.drawCircle(-1, -1, radius, Game.color.white);
	}
	
	public function drawPupil(sprite:FlxSprite) {
		var diameter = Settings.unitLength(0.4);
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
		paddleBack.makeGraphic(UI.teamSettings.paddleBackSize, UI.teamSettings.paddleBackSize);
	}
	
	private inline function newKey(key:String):Bool {
		return !FlxG.bitmap.checkCache(key);
	}
	
	public function renderSvg(path:String):BitmapData {
		if (FlxG.bitmap.checkCache(path)) return FlxG.bitmap.get(path).bitmap;
		
		var svg:SVG = null;
		
		try {
			svg = new SVG(Assets.getText(path));
		}
		catch (e:Dynamic) {
			return FlxAssets.getBitmapFromClass(GraphicLogo);
		}
		
		var bitmapData = new BitmapData(cast svg.data.width, cast svg.data.height, true, 0x0);
		
		_svgShape.graphics.clear();
		svg.render(_svgShape.graphics);
		bitmapData.draw(_svgShape);
		
		FlxG.bitmap.add(bitmapData, true, path);
		
		return bitmapData;
	}
	
}