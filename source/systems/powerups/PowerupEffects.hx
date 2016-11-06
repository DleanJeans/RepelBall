package systems.powerups;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import objects.Ball;

class PowerupEffects {
	public var powerups:Array<Ball->Void>;
	
	public function new() {
		powerups = [ doubleClone, tripleClone ];
	}
	
	public function doubleClone(ball:Ball) {
		var clone = Game.pools.cloneBall(ball);
		var directionAngle = ball.velocity.angleBetween(FlxPoint.weak());
		
		var newPosition = getPointAwayFrom(ball.getCenter(), -Settings.unitLength(0.5), directionAngle);
		var newPosition2 = getPointAwayFrom(ball.getCenter(), Settings.unitLength(0.5), directionAngle);
		
		ball.setCenter(newPosition);
		clone.setCenter(newPosition2);
		
		rotateBallDirection(ball, 30);
		rotateBallDirection(clone, -30);
		
		Game.ball.manager.addBallToLevel(clone);
		Game.signals.ball_hit.dispatch(clone, null);
		
		newPosition.put();
		newPosition2.put();
	}
	
	public function tripleClone(ball:Ball) {
		var clone = Game.pools.cloneBall(ball);
		var clone2 = Game.pools.cloneBall(ball);
		var directionAngle = ball.velocity.angleBetween(FlxPoint.weak());
		
		var newPosition = getPointAwayFrom(ball.getCenter(), Settings.unitLength(1), directionAngle);
		var newPosition2 = getPointAwayFrom(ball.getCenter(), -Settings.unitLength(1), directionAngle);
		
		clone.setCenter(newPosition);
		clone2.setCenter(newPosition2);
		
		rotateBallDirection(clone, -45);
		rotateBallDirection(clone2, 45);
		
		Game.ball.manager.addBallToLevel(clone);
		Game.ball.manager.addBallToLevel(clone2);
		
		Game.signals.ball_hit.dispatch(clone, null);
		Game.signals.ball_hit.dispatch(clone2, null);
		
		newPosition.put();
		newPosition2.put();
	}
	
	private inline function getPointAwayFrom(point:FlxPoint, distance:Float, angle:Float):FlxPoint {
		return point.copyTo().addPoint(FlxAngle.getCartesianCoords(distance, angle));
	}
	
	private inline function rotateBallDirection(ball:Ball, byAngle:Float) {
		ball.velocity.rotate(FlxPoint.weak(), byAngle);
	}
	
	private inline function boostBallSpeed(ball:Ball, extraScale:Float) {
		ball.velocity.scale(1 - extraScale);
	}
	
}