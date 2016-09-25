package systems.ball;
import flixel.util.FlxColor;
import objects.Ball;
import objects.Paddle;

import flixel.tweens.FlxTween;

class BallEffect {
	public function new() {}
	
	public inline function popOnCollision(ball:Ball, object:Dynamic) {
		pop(ball);
		if (Std.is(object, Ball))
			pop(cast object);
	}
	
	public inline function tweenColorOnHittingPaddle(ball:Ball, paddle:Paddle) {
		tweenColor(ball, paddle.color);
	}
	
	public inline function pop(ball:Ball) {
		ball.scale.set(2, 2);
		FlxTween.tween(ball.scale, { x:1, y:1 }, Game.settings.BALL_FX_DURATION);
	}
	
	public inline function tweenColor(ball:Ball, newColor:FlxColor) {
		FlxTween.color(ball, Game.settings.BALL_FX_DURATION, ball.color, newColor);
	}
	
}