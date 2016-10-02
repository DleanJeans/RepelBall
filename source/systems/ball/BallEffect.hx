package systems.ball;

import flixel.util.FlxColor;
import objects.Ball;
import objects.Paddle;

class BallEffect {
	public function new() {}
	
	public inline function popOnCollision(ball:Ball, object:Dynamic) {
		pop(ball);
		if (Std.is(object, Ball))
			pop(cast object);
	}
	
	public inline function tweenColor(ball:Ball, object:Dynamic) {
		var newColor = Std.is(object, Paddle) ? paddleColor(object) : ball.color;
		Game.tween.ballColor(ball, newColor);
	}
	
	private function paddleColor(paddle:Paddle) {
		return paddle.color;
	}
	
	public inline function pop(ball:Ball) {
		ball.scale.set(2, 2);
		Game.tween.ballScale(ball, 1, 1);
	}
	
}