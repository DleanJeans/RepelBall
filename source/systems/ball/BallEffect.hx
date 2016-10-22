package systems.ball;

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
		if (Std.is(object, Paddle))
			ball.originalColor = paddleColor(object);
		Game.tween.ballColor(ball, ball.originalColor);
	}
	
	private inline function paddleColor(paddle:Paddle) {
		return paddle.color;
	}
	
	public inline function pop(ball:Ball) {
		ball.scale.set(2, 2);
		Game.tween.ballScale(ball, 1, 1);
	}
	
}