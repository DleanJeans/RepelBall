package objects;

import flixel.FlxSprite;
import flixel.tweens.misc.ColorTween;
import flixel.tweens.misc.VarTween;
import flixel.util.FlxColor;
import objects.Paddle;
import systems.timers.PowerupTimer;
import systems.timers.SolidTimer;
using flixel.util.FlxSpriteUtil;

class Ball extends FlxSprite {
	@:allow(systems.ball.BallSpeed)
	public var speedBoost(default, null):Int;
	
	public var lastHitPaddle:Paddle;
	public var originalColor:FlxColor;
	
	public var colorTween:ColorTween;
	public var scaleTween:VarTween;
	
	public var solidTimer(default, null):SolidTimer;
	public var powerupTimer(default, null):PowerupTimer;
	
	public function new() {
		super();
		solidTimer = new SolidTimer(this);
		powerupTimer = new PowerupTimer(this);
		elasticity = 1;
		drawBall();
	}
	
	override public function kill():Void {
		super.kill();
		powerupTimer.stopAll();
	}
	
	public function cloneBall():Ball {
		var clone = Game.pools.getBall(this.getCenter(), velocity);
		clone.setColor(originalColor);
		clone.speedBoost = speedBoost;
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
		solidTimer.disableFor(0.2);
	}
	
	public function startPowerupTimer(deactive:Ball->Void) {
		powerupTimer.start(deactive);
	}
	
	public function resetColor() {
		setColor(Game.color.white);
	}
	
	public inline function resetSpeed() {
		Game.ball.speed.resetBallSpeed(this);
	}
	
	private inline function drawBall() {
		Game.renderer.drawBall(this);
	}
}