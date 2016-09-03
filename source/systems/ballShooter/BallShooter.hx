package systems.ballShooter;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import objects.Ball;
import objects.Paddle;
using flixel.addons.util.position.FlxPosition;

class BallShooter {
	public var maxBalls(default, set):Int = 1;
	public var interval(default, null):Float = 0.5;
	public var position(default, null):FlxPoint;
	public var queue(default, null):Array<FlxPoint>;
	
	private var _elapsed:Float = 0;

	public function new() {
		FlxG.signals.postUpdate.add(update);
		
		position = FlxPoint.get(FlxG.width / 2, FlxG.height / 2);
		queue = new Array<FlxPoint>();
	}
	
	public inline function spawnInstantly() {
		_elapsed = interval;
	}
	
	public function push(paddle:Paddle) {
		queue.push(paddle.startingPosition);
	}
	
	public function update() {
		if (queue.length > 0) {
			_elapsed += FlxG.elapsed;
			if (_elapsed >= interval) {
				_elapsed = 0;
				shootAroundStartingPoint(queue.shift());
			}
		}
	}
	
	private function shootAroundStartingPoint(startingPoint:FlxPoint) {
		var projectile = getProjectileVector(startingPoint);
		var ball = Game.pools.getBall(position, projectile);
		Game.level.addBall(ball);
		projectile.put();
	}
	
	private inline function getProjectileVector(startingPoint:FlxPoint):FlxVector {
		var projectile = FlxVector.get();
		projectile.copyFrom(startingPoint.copyTo().subtractPoint(position));
		projectile.rotate(FlxPoint.weak(), FlxG.random.int( -45, 45));
		projectile.length = Game.settings.BALL_STARTING_SPEED;
		return projectile;
	}
	
	function set_maxBalls(newMaxBalls:Int):Int {
		if (maxBalls <= 0)
			maxBalls = 1;
		return maxBalls = newMaxBalls;
	}
	
}