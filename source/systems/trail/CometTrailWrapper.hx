package systems.trail;

import flixel.tweens.misc.ColorTween;
import flixel.util.FlxColor;
import objects.Ball;
import objects.Paddle;
import systems.trail.CometTrail.Trail;

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
	
	public function updateTrailColor(ball:Ball, object:Dynamic) {
		var trail = trail.getTrail(ball);
		var newColor = Std.is(object, Paddle) ? paddleToTrailColor(object) : trail.color;
		if (tweenFinished())
			tween = Game.tween.trailColor(trail, newColor);
	}
	
	private inline function paddleToTrailColor(paddle:Paddle):FlxColor {
		var color = paddle.color;
		color.alphaFloat = 0.5;
		return color;
	}
	
	private inline function tweenFinished() {
		return tween == null || tween.finished;
	}
	
	private inline function cancelTween(trail:Trail) {
		if (tween != null && !tween.finished) {
			tween.cancel();
			trail.color = cast Reflect.getProperty(tween, "endColor");
		}
	}
	
}