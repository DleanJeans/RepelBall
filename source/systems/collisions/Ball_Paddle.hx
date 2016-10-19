package systems.collisions;

import flixel.FlxObject;
import objects.Ball;
import objects.Paddle;
import systems.ArrayLoop.TypedArrayLoop;

class Ball_Paddle {
	private var ball:Ball;
	private var paddle:Paddle;
	private var facingLoop:TypedArrayLoop<Int>;
	
	public function new() {
		facingLoop = new TypedArrayLoop<Int>([FlxObject.LEFT, FlxObject.UP, FlxObject.RIGHT, FlxObject.DOWN]);
	}
	
	private inline function setReferences(ball:Ball, paddle:Paddle) {
		this.ball = ball;
		this.paddle = paddle;
	}
	
	private inline function clearReferences() {
		ball = null;
		paddle = null;
	}
	
	public function update(ball:Ball, paddle:Paddle) {
		setReferences(ball, paddle);
		
		separate();
		if (paddleNotTouchedOppositeFacingSide())
			deflectBall();
		
		clearReferences();
	}
	
	private function paddleNotTouchedOppositeFacingSide() {
		facingLoop.setToIndexOf(paddle.facing);
		var oppositeFacing = facingLoop.add(2, GET_ONLY);
		return paddle.facing != FlxObject.NONE && paddle.facing != oppositeFacing;
	}
	
	private function separate() {
		paddle.immovable = true;
		FlxObject.separate(ball, paddle);
		paddle.immovable = false;
		moveBallAbovePaddle();
	}
	
	private function moveBallAbovePaddle() {
		switch (paddle.facing) {
			case FlxObject.UP:
				ball.setBottom(paddle.y) - 1;
			case FlxObject.DOWN:
				ball.y = paddle.getBottom() + 1;
			case FlxObject.LEFT:
				ball.x = paddle.getRight() - 1;
			case FlxObject.RIGHT:
				ball.setRight(paddle.x) + 1;
		}
	}
	
	private function deflectBall() {
		var maxAngle = 45;
		var normalizedAngle = getNormalizedAngle();
		var newAngle = calculateNewAngle(maxAngle, normalizedAngle);
		var newVelocity = FlxVelocity.velocityFromAngle(newAngle, ball.speed);
		
		ball.velocity.copyFrom(newVelocity);
		newVelocity.put();
	}
	
	private function getNormalizedAngle():Float {
		var paddleCenter = paddle.get1Axis(paddle.getCenter());
		var ballCenter = paddle.get1Axis(ball.getCenter());
		var centerDifference = ballCenter - paddleCenter;
		return centerDifference / paddle.length * 2;
	}
	
	private function calculateNewAngle(maxAngle:Int, normalizedAngle:Float) {
		var newAngle = FlxAngle.angleFromFacing(paddle.facing, true);
		var angle = maxAngle * normalizedAngle;
		
		if (paddle.facing == FlxObject.RIGHT || paddle.facing == FlxObject.UP)
			newAngle += angle;
		else if (paddle.facing == FlxObject.LEFT || paddle.facing == FlxObject.DOWN)
			newAngle -= angle;
		
		return newAngle;
	}
	
}