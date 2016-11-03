package systems.paddle;

import flixel.FlxObject;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import objects.Paddle;
import objects.Wall;

class PaddlePositioner {
	public function new() {}
	
	public function putAboveGoal(paddle:Paddle, wall:Wall, ?unitHeight:Int) {
		if (unitHeight == null)
			unitHeight = 3;
		
		var height = Settings.unitLength(unitHeight);
		var wallCenter = wall.getCenter();
		var heightVector = FlxPoint.weak(0, -height);
		var facingAngle = FlxAngle.angleFromFacing(wall.facing, true);
		
		heightVector.rotate(FlxPoint.weak(), facingAngle + 90);
		heightVector.addPoint(wallCenter);
		
		paddle.startingPosition.copyFrom(heightVector);
		paddle.resetToStartingPosition();
		paddle.facing = wall.facing;
		paddle.allowCollisions = FlxObject.ANY ^ paddle.facing;
	}
	
	public inline function resetPosition(paddle:Paddle) {
		paddle.resetToStartingPosition();
	}
}