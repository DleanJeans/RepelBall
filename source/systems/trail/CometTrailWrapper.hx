package systems.trail;

import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.ColorTween;
import flixel.util.FlxColor;
import objects.Ball;
import objects.Paddle;

class CometTrailWrapper {
	public var trail(default, null):CometTrail;
	public var tween(default, null):ColorTween;
	
	public function new() {
		trail = new CometTrail();
		Game.level.addParticle(trail);
	}
	
	public inline function enable() {
		trail.active = true;
		trail.visible = true;
	}
	
	public inline function disable() {
		trail.active = false;
		trail.visible = false;
	}
	
	public function removeAll() {
		trail.removeAll();
	}
	
	public inline function addBall(ball:Ball) {
		trail.add(ball);
	}
	
	public function updateTrailColor(ball:Ball, tween:FlxTween) {
		var trail = trail.getTrail(ball);
		trail.color = ball.color.getLightened(0.5);
		trail.color.alphaFloat = FlxMath.lerp(1, 0.5, tween.percent);
	}
	
	private inline function paddleToTrailColor(paddle:Paddle):FlxColor {
		var color = paddle.color;
		color.alphaFloat = 0.5;
		color = color.getLightened(0.5);
		return color;
	}
	
	private inline function tweenFinished() {
		return tween == null || tween.finished;
	}
	
}