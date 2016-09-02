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
}