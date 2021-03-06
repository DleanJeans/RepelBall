package systems.ai;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
import systems.controllers.Controller;

class SimpleAI extends Controller {
	public function new(?paddle:Paddle) {
		super(paddle);
	}
	
	override public function update(elapsed:Float):Void {
		if (paddle == null) return;
		
		var nearestBall = getNearestBall();
		controlPaddle(nearestBall);
	}
	
	private function getNearestBall() {
		return Game.ball.manager.findNearestBall(paddle);
	}
	
	private function controlPaddle(nearestBall:Ball) {
		var dist = getDistance(nearestBall);
		var paddleVelocity = paddle.get1Axis(paddle.velocity);
		
		if (distanceTooCloseToMove(dist, paddle.speed)) {
			Game.paddle.movement.stop(paddle);
		}
		else if (paddle.facing == FlxObject.UP || paddle.facing == FlxObject.RIGHT) {
			if (dist < 0)
				Game.paddle.movement.moveLeft(paddle);
			else Game.paddle.movement.moveRight(paddle);
		}
		else if (paddle.facing == FlxObject.DOWN || paddle.facing == FlxObject.LEFT) {
			if (dist < 0)
				Game.paddle.movement.moveRight(paddle);
			else Game.paddle.movement.moveLeft(paddle);
		}
	}
	
	private function distanceTooCloseToMove(dist:Float, speed:Float) {
		return Math.abs(dist) < speed * FlxG.elapsed;
	}
	
	private function getDistance(nearestBall:Ball) {
		var dest:Float = 0;
		var paddleCenterParallel = paddle.get1Axis(paddle.getCenter());
		
		if (nearestBall == null) {
			var startingAxis = paddle.get1Axis(paddle.startingPosition);
			dest = startingAxis;
		}
		else {
			var ballCenterParallel = paddle.get1Axis(nearestBall.getCenter());
			var paddleCenterPerp = paddle.get1Axis(paddle.getCenter(), false);
			var ballCenterPerp = paddle.get1Axis(nearestBall.getCenter(), false);
			
			var ballVelocityParallel = paddle.get1Axis(nearestBall.velocity);
			var ballVelocityPerp = paddle.get1Axis(nearestBall.velocity, false);
			
			var distanceToPaddle = paddleCenterPerp - ballCenterPerp;
			var timeToPaddle = distanceToPaddle / ballVelocityPerp;
			
			dest = ballCenterParallel + ballVelocityParallel * timeToPaddle;
		}
		
		return dest - paddleCenterParallel;
	}
	
}