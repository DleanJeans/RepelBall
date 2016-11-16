package systems.trail;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.ColorTween;
import objects.Ball;

class CometTrailWrapper {
	public var manager(default, null):CometTrailManager;
	public var tween(default, null):ColorTween;
	
	public function new() {
		manager = new CometTrailManager();
		manager.cooldown = Settings.trail.cooldown;
		manager.nodeLimit = Settings.trail.nodeLimit;
		Game.stage.addParticle(manager.canvas);
		Game.stage.addSystem(manager);
	}
	
	public inline function enable() {
		manager.visible = true;
	}
	
	public inline function disable() {
		manager.visible = false;
	}
	
	public function clearCanvas() {
		manager.clearCanvas();
	}
	
	public inline function addBall(ball:Ball) {
		manager.addSprite(ball);
	}
	
	public function removeBall(ball:Ball) {
		manager.removeSprite(ball);
	}
	
	public function removeAll() {
		manager.removeAll();
	}
	
	public function getTrail(ball:Ball):CometTrail {
		return manager.getTrail(ball);
	}
	
	public function updateTrailColor(ball:Ball, tween:FlxTween) {
		var trail = getTrail(ball);
		if (trail == null) return;
		trail.color = ball.color.getLightened(0.15);
		if (tween != null)
			trail.color.alphaFloat = FlxMath.lerp(1, 0.5, tween.percent);
	}
	
}