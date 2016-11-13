package systems.powerups;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.helpers.FlxBounds;
import objects.Ball;

class ClonePowerups {
	private var _upperBounds = new FlxBounds<Float>(0);
	private var _lowerBounds = new FlxBounds<Float>(0);
	
	public function new() {}

	public function doubleClone(ball:Ball) {
		boundBallAngle(ball);
		
		var clone = Game.pools.cloneBall(ball);
		
		rotateBallByAngle(ball, 30);
		rotateBallByAngle(clone, -30);
		
		Game.ball.manager.addBallToLevel(clone);
		Game.ball.fx.pop(clone);
		Game.ball.fx.tweenColor(clone, null);
	}
	
	public function tripleClone(ball:Ball) {
		boundBallAngle(ball, 30);
		
		var clone = Game.pools.cloneBall(ball);
		var clone2 = Game.pools.cloneBall(ball);
		
		rotateBallByAngle(clone, -45);
		rotateBallByAngle(clone2, 45);
		
		Game.ball.manager.addBallToLevel(clone);
		Game.ball.manager.addBallToLevel(clone2);
		
		Game.ball.fx.pop(clone);
		Game.ball.fx.pop(clone2);
		
		Game.ball.fx.tweenColor(clone, null);
		Game.ball.fx.tweenColor(clone2, null);
	}
	
	private function boundBallAngle(ball:Ball, range:Int = 60) {
		var angle = getAngle(ball);
		_upperBounds.set( -90 - range / 2, -90 + range / 2);
		_lowerBounds.set(90 - range / 2, 90 + range / 2);
		
		if (ball.velocity.y < 0) {
			if (!FlxMath.inBounds(angle, _upperBounds.min, _upperBounds.max))
				rotateBallToAngle(ball, angle = FlxMath.bound(angle, _upperBounds.min, _upperBounds.max));
		}
		else {
			if (!FlxMath.inBounds(angle, _lowerBounds.min, _lowerBounds.max))
				rotateBallToAngle(ball, angle = FlxMath.bound(angle, _lowerBounds.min, _lowerBounds.max));
		}
	}
	
	private function rotateBallToAngle(ball:Ball, toAngle:Float) {
		var currentAngle = getAngle(ball);
		ball.velocity.rotate(FlxPoint.weak(), toAngle - currentAngle);
	}
	
	private inline function getAngle(ball:Ball) {
		return FlxAngle.wrapAngle(ball.velocity.angleBetween(FlxPoint.weak()) + 90);
	}
	
	private inline function rotateBallByAngle(ball:Ball, byAngle:Float) {
		ball.velocity.rotate(FlxPoint.weak(), byAngle);
	}
	
	private inline function boostBallSpeed(ball:Ball, extraScale:Float) {
		ball.velocity.scale(1 - extraScale);
	}
	
}