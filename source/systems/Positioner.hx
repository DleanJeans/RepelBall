package systems;

import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import objects.Paddle;
import objects.Wall;
using flixel.addons.util.position.FlxPosition;

class Positioner {

	public function new() {}
	
	public function putPaddleOnGoal(paddle:Paddle, wall:Wall, ?height:Int) {
		if (height == null)
			height = Game.unitLength(3);
		
		var wallCenter = wall.getCenter();
		var heightVector = FlxPoint.weak(0, -height);
		var facingAngle = FlxAngle.angleFromFacing(wall.facing, true);
		
		heightVector.rotate(FlxPoint.weak(), facingAngle + 90);
		heightVector.addPoint(wallCenter);
		
		paddle.startingPoint.copyFrom(heightVector);
		paddle.resetPosition();
		paddle.facing = wall.facing;
	}
}