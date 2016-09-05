package systems.ai;

import flixel.FlxG;
import flixel.math.FlxMath;
import objects.Ball;
import objects.Paddle;
import systems.controllers.Controller;
using flixel.addons.util.position.FlxPosition;

class ExpressionAI extends Controller {
	public static var DISTANCE_THRESHOLD = 400;
	public static var OUT_RANGE = 100;
	
	public function new(paddle:Paddle) {
		super(paddle);
	}
	
	override public function update(elapsed:Float):Void {
		if (paddle == null) return;
		
		var nearestBall = getNearestBall();
		if (nearestBall != null)
			controlExpression(nearestBall);
	}
	
	private function getNearestBall() {
		return Game.ballManager.findNearestBall(paddle);
	}
	
	private function controlExpression(nearestBall:Ball) {
		var expression = Game.paddleExpression.smile;
		if (notTooFaraway(nearestBall) && notReachable(nearestBall))
			expression = Game.paddleExpression.frown;
		
		expression(paddle);
	}
	
	private function notTooFaraway(nearestBall:Ball) {
		var paddleCenter = paddle.get1Axis(paddle.getCenter(), false);
		var ballCenter = paddle.get1Axis(nearestBall.getCenter(), false);
		var distance = Math.abs(paddleCenter - ballCenter);
		return  distance <= DISTANCE_THRESHOLD;
	}
	
	private inline function notReachable(ball:Ball) {
		return
		if (paddle.movesHorizontally())
			ball.getRight() < paddle.x - OUT_RANGE || ball.x > paddle.getRight() + OUT_RANGE
		else ball.getBottom() < paddle.y - OUT_RANGE || ball.y > paddle.getBottom() + OUT_RANGE;
	}
	
}