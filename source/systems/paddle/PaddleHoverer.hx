package systems.paddle;

import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import objects.Paddle;

typedef TweenMap = Map<Paddle, FlxTween>;

class PaddleHoverer {
	public var tweenMap(default, null):TweenMap;
	
	public function new() {
		tweenMap = new TweenMap();
	}
	
	public function startHoveringAllPaddles() {
		for (paddle in Game.level.paddles)
			startHovering(paddle, Game.unitLength(0.75));
	}
	
	public function stopHoveringAllPaddles() {
		for (paddle in Game.level.paddles)
			stopHovering(paddle);
	}
	
	public function pauseAllHovering() {
		for (tween in tweenMap)
			tween.active = false;
	}
	
	public function resumeAllHovering() {
		for (tween in tweenMap)
			tween.active = true;
	}
	
	public function startHovering(paddle:Paddle, range:Float = 10) {
		paddle.offset.y -= range / 2;
		var delay = FlxG.random.float(0, 0.5);
		var tween = FlxTween.tween(paddle.offset, { y:paddle.offset.y + range }, 0.5, { type:FlxTween.PINGPONG, ease:FlxEase.sineInOut, startDelay:delay });
		tweenMap.set(paddle, tween);
	}
	
	
	public function stopHovering(paddle:Paddle, resetPosition:Bool = false) {
		var tween = tweenMap.get(paddle);
		if (tween != null) {
			tween.cancel();
			tweenMap.remove(paddle);
			if (resetPosition)
				paddle.resetToStartingPosition();
		}
	}
}