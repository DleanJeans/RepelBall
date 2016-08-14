package systems.controllers;

import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import objects.Paddle;

class PaddleMovement {
	public function new() {}
	
	public inline function stop(paddle:Paddle) {
		paddle.velocity.set();
	}
	
	public inline function moveLeft(paddle:Paddle) {
		move(paddle, FlxPoint.weak(-paddle.speed));
	}
	
	public inline function moveRight(paddle:Paddle) {
		move(paddle, FlxPoint.weak(paddle.speed));
	}
	
	private function move(paddle:Paddle, distance:FlxPoint) {
		rotateDistanceMatchingFacing(paddle, distance);
		paddle.velocity.copyFrom(distance);
		distance.putWeak();
	}
	
	private function rotateDistanceMatchingFacing(paddle:Paddle, distance:FlxPoint) {
		var facingAngle = FlxAngle.angleFromFacing(paddle.facing, true);
		distance.rotate(FlxPoint.weak(), facingAngle + 90);
	}
}