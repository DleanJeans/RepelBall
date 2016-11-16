package systems;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.ColorTween;
import flixel.tweens.misc.VarTween;
import flixel.util.FlxColor;
import objects.Ball;
import objects.PaddleWrapper;
import objects.Powerup;

class Tweens {
	public function new() {}
	
	public function powerupHovering(powerup:Powerup) {
		var minScale = Settings.powerup.hoveringScale.min;
		var duration = FlxG.random.float(Settings.duration.hovering.min, Settings.duration.hovering.max);
		var values = { x:minScale, y:minScale };
		stopTween(powerup.scaleTween);
		
		powerup.scaleTween = FlxTween.tween(powerup.scale, values, duration, { type:FlxTween.PINGPONG, ease:FlxEase.sineInOut });
	}
	
	public inline function powerupScale(powerup:Powerup, newScaleX:Float, newScaleY:Float, ?onComplete:TweenCallback) {
		stopTween(powerup.scaleTween);
		powerup.scaleTween = FlxTween.tween(powerup.scale, { x:newScaleX, y:newScaleY }, Settings.powerup.popDuration,
		{ type:FlxTween.PERSIST, ease:FlxEase.backOut, onComplete:onComplete });
	}
	
	public inline function colorSwatchSelector(selector:FlxSprite, x:Float, y:Float):VarTween {
		return FlxTween.tween(selector, { x:x, y:y }, 0.25, { ease:FlxEase.quartOut });
	}
	
	public function ballColor(ball:Ball, newColor:FlxColor, ?onComplete:TweenCallback) {
		restartTween(ball.colorTween);
		if (ball.colorTween == null)
			ball.colorTween = FlxTween.color(ball, Settings.ball.fxDuration, Game.color.white, newColor, 
			{ type:FlxTween.PERSIST, onUpdate:Game.cometTrail.updateTrailColor.bind(ball), onComplete:onComplete });
		else ball.colorTween.tween(Settings.ball.fxDuration, Game.color.white, newColor, ball);
	}
	
	public function ballScale(ball:Ball, newScaleX:Float, newScaleY:Float) {
		restartTween(ball.scaleTween);
		if (ball.scaleTween == null)
			ball.scaleTween = FlxTween.tween(ball.scale, { x:newScaleX, y:newScaleY }, Settings.ball.fxDuration, { type:FlxTween.PERSIST });
	}
	
	public inline function paddleHovering(hoveringOffset:FlxPoint, down:FlxPoint, ?onUpdate:TweenCallback):VarTween {
		var duration = FlxG.random.float(Settings.duration.hovering.min, Settings.duration.hovering.max);
		var delay = FlxG.random.float(0, Settings.paddle.maxHoveringDelay);
		var values = { x:hoveringOffset.x + down.x, y:hoveringOffset.y + down.y };
		
		return FlxTween.tween(hoveringOffset, values , duration,
		{ type:FlxTween.PINGPONG, ease:FlxEase.sineInOut, startDelay:delay, onUpdate:onUpdate });
	}
	
	public inline function paddleKnockBack(knockBackOffset:FlxPoint, down:FlxPoint) {
		var halfDuration = Settings.paddle.maxHoveringDelay / 2;
		
		return FlxTween.tween(knockBackOffset, { x:down.x, y:down.y }, halfDuration)
		.then(FlxTween.tween(knockBackOffset, { x:0, y:0 }, halfDuration));
	}
	
	public inline function paddleScaleUpAndDown(wrapper:PaddleWrapper) {
		return paddleScale(wrapper, 2, 2)
		.then(paddleScale(wrapper, 1, 1));
	}
	
	public inline function paddleScale(wrapper:PaddleWrapper, newScaleX:Float, newScaleY:Float):VarTween {
		var options = { onUpdate:Game.paddle.expression.tweenUpdateEyeSeparation.bind(wrapper.paddle), ease:FlxEase.sineOut };
		var duration = Settings.duration.paddleColorTween;
		
		return FlxTween.tween(wrapper.scale, { x:newScaleX, y:newScaleY }, duration / 2, options);
	}
	
	public inline function paddleColor(wrapper:PaddleWrapper, newColor:FlxColor):ColorTween {
		var options = { onUpdate:lockPaddleWrapperAlphaTo1.bind(wrapper) };
		var duration = Settings.duration.paddleColorTween;
		
		return FlxTween.color(wrapper, duration, wrapper.color, newColor, options);
	}
	
	private inline function lockPaddleWrapperAlphaTo1(wrapper:PaddleWrapper, tween:FlxTween) {
		wrapper.color.alphaFloat = 1;
	}
	
	public function stopTween(tween:FlxTween) {
		if (tween != null && !tween.finished)
			tween.cancel();
	}
	
	private function restartTween(tween:FlxTween) {
		if (tween != null)
			tween.start();
	}
	
}