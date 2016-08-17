package systems;

import flixel.FlxG;
import flixel.math.FlxPoint;
import objects.Ball;
import objects.Paddle;
using flixel.addons.util.position.FlxPosition;

class BallShooter {
	public var maxBalls(default, set):Int = 1;
	public var interval(default, null):Float = 0.2;
	public var position(default, null):FlxPoint;
	public var queue(default, null):Array<FlxPoint>;
	
	private var _elapsed:Float = 0;

	public function new() {
		FlxG.signals.preUpdate.add(update);
		
		position = FlxPoint.get(FlxG.width / 2, FlxG.height / 2);
		queue = new Array<FlxPoint>();
	}
	
	public function push(paddle:Paddle) {
		queue.push(paddle.startingPoint);
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
		var projectileVector = startingPoint.copyTo().subtractPoint(position);
		projectileVector.rotate(FlxPoint.weak(), FlxG.random.int( -45, 45));
		
		var ball = Game.pools.getBall(position, projectileVector);
		Game.level.addBall(ball);
	}
	
	function set_maxBalls(newMaxBalls:Int):Int {
		if (maxBalls <= 0)
			maxBalls = 1;
		return maxBalls = newMaxBalls;
	}
	
}