package systems.ai;

import flixel.FlxG;
import flixel.math.FlxMath;
import objects.Ball;
import objects.Paddle;
import systems.controllers.Controller;
using Positioner;

class ExpressionAI extends Controller {
	public static var DISTANCE_THRESHOLD = 400;
	public static var OUT_RANGE = 100;
	
	public function new(paddle:Paddle) {
		super(paddle);
	}
	
	override public function update(elapsed:Float):Void {
		if (paddle == null) return;
		
		var nearestBall = getNearestBall();
		controlExpression(nearestBall);
	}
	
	private function getNearestBall() {
		return Game.ball.manager.findNearestBall(paddle);
	}
	
	private function controlExpression(nearestBall:Ball) {
		var expression = Game.paddle.expression.smile;
		if (nearestBall == null)
			expression = Game.paddle.expression.shut;
		else if (notTooFaraway(nearestBall) && notReachable(nearestBall))
			expression = Game.paddle.expression.frown;
		
		expression(paddle);
	}
	
	private function notTooFaraway(nearestBall:Ball) {
		var paddleCenter = paddle.get1Axis(paddle.getCenter(), false);
		var ballCenter = paddle.get1Axis(nearestBall.getCenter(), false);
		var distance = Math.abs(paddleCenter - ballCenter);
		return  distance <= Game.settings.EXPRESSION_BALL_DETECTION_RADIUS;
	}
	
	private inline function notReachable(ball:Ball) {
		var reach = Game.settings.EXPRESSION_FROWN_BALL_OUT_REACH;
		return
		if (paddle.movesHorizontally())
			ball.getRight() < paddle.x - reach || ball.x > paddle.getRight() + reach
		else ball.getBottom() < paddle.y - reach || ball.y > paddle.getBottom() + reach;
	}
	
}