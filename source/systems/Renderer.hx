package systems;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import objects.Paddle;
using flixel.util.FlxSpriteUtil;

class Renderer {
	public function new() {}
	
	public function drawUnit(sprite:FlxSprite, unitWidth:Float, unitHeight:Float) {
		draw(sprite, Game.unitLength(unitWidth), Game.unitLength(unitHeight));
	}
	
	public function draw(sprite:FlxSprite, width:Float, height:Float) {
		sprite.makeGraphic(cast width, cast height, 0x0);
		sprite.drawRoundRect(0, 0, width, height, Game.unitLength(), Game.unitLength(), FlxColor.WHITE);
	}
	
	public function drawPaddle(paddle:Paddle) {
		if (paddle.movesHorizontally())
			paddle.setSize(paddle.length, Game.unitLength());
		else paddle.setSize(Game.unitLength(), paddle.length);
		
		draw(paddle, paddle.width, paddle.height);
	}
	
}