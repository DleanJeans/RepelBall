package systems.ball;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import objects.Ball;
import objects.Paddle;

class BallShooter extends FlxObject {
	public var maxBalls(default, set):Int = 1;
	public var interval(default, null):Float = 0.1;
	public var position(get, null):FlxPoint;
	public var queue(default, null):Array<FlxPoint>;
	
	private var _elapsed:Float = 0;

	public function new() {
		super();
		Game.stage.addSystem(this);
		setPosition(FlxG.width / 2, FlxG.height / 2);
		queue = new Array<FlxPoint>();
		kill();
	}
	
	public inline function shootInstantly() {
		_elapsed = interval;
	}
	
	public function push(paddle:Paddle) {
		queue.push(paddle.startingPosition);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (tick())
			shoot();
	}
	
	private function tick():Bool {
		if (queue.length > 0) {
			_elapsed += FlxG.elapsed;
			if (_elapsed >= interval) {
				_elapsed = 0;
				return true;
			}
		}
		return false;
	}
	
	private inline function shoot() {
		shootAroundStartingPoint(queue.shift());
	}
	
	private function shootAroundStartingPoint(startingPoint:FlxPoint) {
		var projectile = getProjectileVector(startingPoint);
		var ball = Game.pools.getBall(position, projectile);
		Game.ball.manager.addBallToLevel(ball);
		projectile.put();
	}
	
	private function getProjectileVector(startingPoint:FlxPoint):FlxVector {
		var projectile = FlxVector.get();
		projectile.copyFrom(startingPoint.copyTo().subtractPoint(position));
		projectile.rotate(FlxPoint.weak(), FlxG.random.int( -45, 45));
		projectile.length = Game.ball.speed.globalSpeed;
		return projectile;
	}
	
	function set_maxBalls(newMaxBalls:Int):Int {
		if (maxBalls <= 0)
			maxBalls = 1;
		return maxBalls = newMaxBalls;
	}
	
	function get_position():FlxPoint {
		return FlxPoint.weak(x, y);
	}
	
}