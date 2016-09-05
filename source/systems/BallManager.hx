package systems;

import flixel.FlxG;
import flixel.math.FlxPoint;
import objects.Ball;
import objects.Paddle;
using flixel.addons.util.position.FlxPosition;

typedef BallMap = Map<Paddle, Ball>;

class BallManager {
	public var ballMap(default, null):BallMap;
	
	public function new() {
		ballMap = new BallMap();
		FlxG.signals.postUpdate.add(clearBallMap);
	}
	
	private inline function clearBallMap() {
		for (paddle in ballMap.keys())
			ballMap.remove(paddle);
	}
	
	public function increaseBallSpeed(ball:Ball, paddle:Paddle) {
		if (ball.lastHitPaddle != paddle) {
			ball.increaseSpeed();
			ball.lastHitPaddle = paddle;
		}
	}
	
	public inline function changeBallColor(ball:Ball, paddle:Paddle) {
		ball.color = paddle.color;
	}
	
	public function findNearestBall(paddle:Paddle) {
		var nearest:Ball = null;
		var nearestTime:Float = Math.POSITIVE_INFINITY;
		
		var ballToPaddle = FlxPoint.get();
		var time:Float;
		
		for (ball in Game.level.balls) {
			ballToPaddle.copyFrom(paddle.getCenter().subtractPoint(ball.getCenter()));
			
			if (paddle.movesHorizontally())
				time = ballToPaddle.y / ball.velocity.y;
			else time = ballToPaddle.x / ball.velocity.x;
			
			if (time > 0 && time < nearestTime) {
				nearestTime = time;
				nearest = ball;
			}
		}
		
		ballToPaddle.put();
		
		ballMap.set(paddle, nearest);
		return nearest;
	}
}