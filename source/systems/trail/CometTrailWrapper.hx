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
		if (trail == null) return;
		trail.color = ball.color.getLightened(0.25);
		if (tween != null)
			trail.color.alphaFloat = FlxMath.lerp(1, 0.5, tween.percent);
	}
	
}