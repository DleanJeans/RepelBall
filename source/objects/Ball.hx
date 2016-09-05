package objects;

import flixel.FlxSprite;
import flixel.math.FlxVelocity;
import flixel.util.FlxColor;
import objects.Paddle;
using flixel.util.FlxSpriteUtil;

class Ball extends FlxSprite {
	public var speed(default, null):Int;
	
	public var lastHitPaddle:Paddle;
	
	public function new() {
		super();
		elasticity = 1;
		drawBall();
	}
	
	public inline function resetColor() {
		color = Game.color.white;
	}
	
	public inline function resetSpeed() {
		speed = Game.settings.BALL_STARTING_SPEED;
	}
	
	public inline function increaseSpeed(increment:Int = 50) {
		speed += increment;
	}
	
	private inline function drawBall() {
		Game.renderer.drawUnitRoundRect(this, 1, 1);
	}
}