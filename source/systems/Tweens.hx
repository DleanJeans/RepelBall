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
import objects.Paddle;
import objects.PaddleWrapper;
import systems.trail.CometTrail.Trail;

typedef TypedPaddleTweenMap<T:FlxTween> = Map<Paddle, T>;
typedef PaddleTweenMap = TypedPaddleTweenMap<FlxTween>;

typedef TypedBallTweenMap<T:FlxTween> = Map<Ball, T>;
typedef BallTweenMap = TypedBallTweenMap<FlxTween>;

enum Restart {
	DO_RESTART;
	NO_RESTART;
}

class Tweens {
	public var hoverers(default, null):PaddleTweenMap;
	public var squeezers(default, null):PaddleTweenMap;
	public var ballColors(default, null):TypedBallTweenMap<ColorTween>;
	public var ballScales(default, null):BallTweenMap;
	
	public function new() {
		hoverers = new PaddleTweenMap();
		squeezers = new PaddleTweenMap();
		ballColors = new TypedBallTweenMap<ColorTween>();
		ballScales = new BallTweenMap();
	}
	
	private function cancelTween<T1:FlxSprite, T2:FlxTween>(map:Map<T1, T2>, sprite:FlxSprite):T2 {
		var tween:FlxTween = map.get(cast sprite);
		if (tween != null && !tween.finished)
			tween.cancel();
		return cast tween;
	}
	
	private function restartTween<T1:FlxSprite, T2:FlxTween>(map:Map<T1, T2>, sprite:FlxSprite, ?restart:Restart):T2 {
		restart = restart == null ? DO_RESTART : restart;
		var tween = map[cast sprite];
		if (tween != null && restart == DO_RESTART)
			tween.start();
		return tween;
	}
	
	public inline function colorSwatchSelector(selector:FlxSprite, x:Float, y:Float):VarTween {
		return FlxTween.tween(selector, { x:x, y:y }, 0.25, { ease:FlxEase.quartOut });
	}
	
	public function ballScale(ball:Ball, newScaleX:Float, newScaleY:Float) {
		var tween = restartTween(ballScales, ball);
		if (tween == null) {
			tween = FlxTween.tween(ball.scale, { x:newScaleX, y:newScaleY }, Game.settings.BALL_FX_DURATION, { type:FlxTween.PERSIST });
			ballScales[ball] = tween;
		}
		return tween;
	}
	
	public function ballColor(ball:Ball, newColor:FlxColor):ColorTween {
		var tween = restartTween(ballColors, ball, NO_RESTART);
		if (tween == null) {
			tween = FlxTween.color(ball, Game.settings.BALL_FX_DURATION, Game.color.white, newColor, { type:FlxTween.PERSIST });
			ballColors[ball] = tween;
		}
		else {
			tween.tween(Game.settings.BALL_FX_DURATION, Game.color.white, newColor, ball);
		}
		return tween;
	}
	
	public inline function trailColor(trail:Trail, newColor:FlxColor):ColorTween {
		return FlxTween.color(null, Game.settings.BALL_FX_DURATION, Game.color.white, newColor,
		{ onUpdate: function (t:FlxTween) trail.color = cast(t, ColorTween).color });
	}
	
	public inline function paddleScaleUpAndDown(wrapper:PaddleWrapper) {
		return paddleScale(wrapper, 2, 2)
		.then(paddleScale(wrapper, 1, 1));
	}
	
	public inline function paddleScale(wrapper:PaddleWrapper, newScaleX:Float, newScaleY:Float):VarTween {
		var options = { onUpdate:Game.paddle.expression.tweenUpdateEyeSeparation.bind(wrapper.paddle), ease:FlxEase.sineOut };
		var duration = Game.settings.COLOR_CHANGING_TWEEN_DURATION;
		
		return FlxTween.tween(wrapper.scale, { x:newScaleX, y:newScaleY }, duration / 2, options);
	}
	
	public inline function paddleColor(wrapper:PaddleWrapper, newColor:FlxColor):ColorTween {
		var options = { onUpdate:lockPaddleWrapperAlphaAtOne.bind(wrapper) };
		var duration = Game.settings.COLOR_CHANGING_TWEEN_DURATION;
		
		return FlxTween.color(wrapper, duration, wrapper.color, newColor, options);
	}
	
	private inline function lockPaddleWrapperAlphaAtOne(wrapper:PaddleWrapper, tween:FlxTween) {
		wrapper.color.alphaFloat = 1;
	}
	
	public inline function hovering(hoveringOffset:FlxPoint, down:FlxPoint, ?onUpdate:TweenCallback):VarTween {
		var duration = FlxG.random.float(Game.settings.MIN_HOVERING_DURATION, Game.settings.MAX_HOVERING_DURATION);
		var delay = FlxG.random.float(0, Game.settings.MAX_HOVERING_DELAY);
		var values = { x:hoveringOffset.x + down.x, y:hoveringOffset.y + down.y };
		
		return FlxTween.tween(hoveringOffset, values , duration,
		{ type:FlxTween.PINGPONG, ease:FlxEase.sineInOut, startDelay:delay, onUpdate:onUpdate });
	}
	
	public inline function knockBack(knockBackOffset:FlxPoint, down:FlxPoint) {
		var halfDuration = Game.settings.KNOCK_BACK_DURATION / 2;
		
		return FlxTween.tween(knockBackOffset, { x:down.x, y:down.y }, halfDuration)
		.then(FlxTween.tween(knockBackOffset, { x:0, y:0 }, halfDuration));
	}
}