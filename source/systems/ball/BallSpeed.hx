package systems.ball;

import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import objects.Ball;

class BallSpeed {
	public var globalSpeed(default, null):Int;
	
	public function new() {
		resetGlobalSpeed();
	}
	
	public function startRoundTimer() {
		Game.timers.roundTimer.start(10, function(_) increaseGlobalSpeed(), 0);
	}
	
	public inline function resetGlobalSpeed() {
		globalSpeed = Settings.unitLength(10);
	}
	
	public inline function resetBallSpeed(ball:Ball) {
		ball.speedOffset = 0;
	}
	
	public inline function increaseGlobalSpeed(offset:Int = Settings.unitLength(2)) {
		globalSpeed += offset;
		applySpeedToAll();
	}
	
	public inline function increaseBallSpeed(ball:Ball, offset:Int = Settings.unitLength(2)) {
		ball.speedOffset += offset;
		applySpeed(ball);
	}
	
	public inline function applySpeedToAll() {
		Game.stage.balls.forEach(applySpeed);
	}
	
	public inline function applySpeedOnCollision(ball:Ball, object:Dynamic) {
		applySpeed(ball);
	}
	
	public function applySpeed(ball:Ball) {
		var ballSpeed = globalSpeed + ball.speedOffset;
		var actualSpeed = ball.velocity.distanceTo(FlxPoint.weak());
		
		ball.velocity.scale(ballSpeed / actualSpeed);
	}
	
}