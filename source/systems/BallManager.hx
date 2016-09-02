package systems;
import objects.Ball;
import objects.Paddle;

class BallManager {
	public function new() {}
	
	public function increaseBallSpeed(ball:Ball, paddle:Paddle) {
		if (ball.lastHitPaddle != paddle) {
			ball.increaseSpeed();
			ball.lastHitPaddle = paddle;
		}
	}
	
	public inline function changeBallColor(ball:Ball, paddle:Paddle) {
		ball.color = paddle.color;
	}
}