package systems.paddle;

import objects.Paddle;

@:access(objects.Paddle.speedBoost)
class PaddleSpeed {
	public var globalSpeed(default, null):Int;

	public function new() {
		resetGlobalSpeed();
	}
	
	public function resetGlobalSpeed() {
		globalSpeed = Settings.unitLength(20);
	}
	
	public inline function increaseGlobalSpeed(?offset:Int = Settings.unitLength(4)) {
		globalSpeed += offset;
	}
	
	public function boostPaddle(paddle:Paddle, offset:Int = Settings.unitLength(2)) {
		paddle.speedBoost += offset;
	}
	
	public function deboostPaddle(paddle:Paddle, offset:Int = Settings.unitLength(2)) {
		paddle.speedBoost -= offset;
	}
	
}