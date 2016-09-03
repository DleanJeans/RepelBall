package systems;

import flixel.FlxObject;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import objects.Paddle;
import objects.Wall;
using flixel.addons.util.position.FlxPosition;

class Positioner {
	public function new() {}
	
	public function putPaddleOnGoal(paddle:Paddle, wall:Wall, ?unitHeight:Int) {
		if (unitHeight == null)
			unitHeight = 3;
		
		var height = Game.unitLength(unitHeight);
		var wallCenter = wall.getCenter();
		var heightVector = FlxPoint.weak(0, -height);
		var facingAngle = FlxAngle.angleFromFacing(wall.facing, true);
		
		heightVector.rotate(FlxPoint.weak(), facingAngle + 90);
		heightVector.addPoint(wallCenter);
		
		paddle.startingPosition.copyFrom(heightVector);
		paddle.resetPosition();
		paddle.facing = wall.facing;
		paddle.allowCollisions = FlxObject.ANY ^ paddle.facing;
	}
	
	public inline function resetPaddlePosition(paddle:Paddle) {
		paddle.resetPosition();
	}
}