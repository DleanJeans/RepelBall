package objects;

import flixel.FlxSprite;
import flixel.math.FlxVelocity;
import flixel.util.FlxColor;
import objects.Paddle;
import systems.collisions.SolidTimer;
using flixel.util.FlxSpriteUtil;

class Ball extends FlxSprite {
	public var speed(default, null):Int;
	
	public var lastHitPaddle:Paddle;
	public var originalColor:FlxColor;
	public var solidTimer(default, null):SolidTimer;
	
	public function new() {
		super();
		solidTimer = new SolidTimer(this);
		elasticity = 1;
		drawBall();
	}
	
	public function cloneBall():Ball {
		var clone = Game.pools.getBall(this.getCenter(), velocity);
		clone.setColor(originalColor);
		clone.speed = speed;
		return clone;
	}
	
	public inline function setColor(newColor:FlxColor) {
		originalColor = color = newColor;
	}
	
	public inline function resetBall() {
		resetColor();
		resetSpeed();
	}
	
	public function startSolidTimer() {
		solidTimer.disableFor();
	}
	
	public function resetColor() {
		setColor(Game.color.white);
	}
	
	public inline function resetSpeed() {
		speed = Settings.BALL_STARTING_SPEED;
	}
	
	public inline function increaseSpeed(increment:Int = 50) {
		speed += increment;
	}
	
	private inline function drawBall() {
		Game.renderer.drawBall(this);
	}
}