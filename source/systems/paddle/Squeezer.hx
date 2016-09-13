package systems.paddle;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import objects.Paddle;

typedef SqueezerTweenMap = Map<Paddle, FlxTween>;

class Squeezer extends FlxBasic {
	private var tweenMap:SqueezerTweenMap;
	
	public function new() {
		super();
		tweenMap = new SqueezerTweenMap();
		FlxG.plugins.add(this);
	}
	
	public function stopAllTweens() {
		var tween:FlxTween = null;
		for (paddle in Game.level.paddles) {
			tween = getTween(paddle);
			if (tween != null) {
				tween.cancel();
				removeTween(paddle, null);
			}
		}
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		squeezeAllPaddles();
	}
	
	public function squeezeAllPaddles() {
		for (paddle in Game.level.paddles)
			squeezePaddleIfMoving(paddle);
	}
	
	public function squeezePaddleIfMoving(paddle:Paddle) {
		if (paddle.velocity.equals(FlxPoint.weak()))
			unsqueezePaddle(paddle);
		else squeezePaddle(paddle);
	}
	
	public inline function squeezePaddle(paddle:Paddle) {
		var tween = getTween(paddle);
		if (tween != null)
			tween.cancel();
		tween = FlxTween.tween(paddle.wrapper.scale, { x:1.25, y:0.75 }, 0.05, 
		{ onUpdate:updateEyeSeparation.bind(paddle), onComplete: removeTween.bind(paddle) });
		tweenMap.set(paddle, tween);
	}
	
	public inline function unsqueezePaddle(paddle:Paddle) {
		var tween = getTween(paddle);
		if (tween != null)
			tween.cancel();
		tween = FlxTween.tween(paddle.wrapper.scale, { x:1, y:1 }, 0.05, 
		{ onUpdate:updateEyeSeparation.bind(paddle), onComplete: removeTween.bind(paddle) });
		tweenMap.set(paddle, tween);
	}
	
	private inline function updateEyeSeparation(paddle:Paddle, tween:FlxTween) {
		paddle.wrapper.face.eyes.scaleEyeSeparation(paddle.wrapper.scale.x);
	}
	
	private inline function removeTween(paddle:Paddle, tween:FlxTween) {
		tweenMap.remove(paddle);
	}
	
	private inline function getTween(paddle:Paddle):FlxTween {
		return tweenMap.get(paddle);
	}
}