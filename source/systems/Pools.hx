package systems;

import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import objects.Ball;
import objects.Paddle;
import objects.Wall;

typedef Pool<T:FlxBasic> = FlxTypedGroup<T>;
typedef BallPool = Pool<Ball>;
typedef PaddlePool = Pool<Paddle>;
typedef WallPool = Pool<Wall>;

class Pools {
	public var balls(default, null):BallPool;
	public var paddles(default, null):PaddlePool;
	public var walls(default, null):WallPool;
	
	public function new() {
		balls = new BallPool();
		paddles = new PaddlePool();
		walls = new WallPool();
	}
	
	public function getBall(?velocity:FlxPoint):Ball {
		var ball = balls.recycle(Ball);
		if (velocity != null)
			ball.velocity.copyFrom(velocity);
		return ball;
	}
	
	public function getPaddle(speed:Int = 500):Paddle {
		var paddle = paddles.recycle(Paddle);
		paddle.speed = speed;
		return paddle;
	}
	
	public function getWall(x:Float, y:Float, width:Int, height:Int, facing:Int):Wall {
		var wall = walls.recycle(Wall);
		wall.resetWall(x, y, width, height, facing);
		return wall;
	}
	
}