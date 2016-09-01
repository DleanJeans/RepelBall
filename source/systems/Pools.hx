package systems;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
import ui.ColorSwatchSelector;
using flixel.addons.util.position.FlxPosition;

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
	
	public function getBall(?position:FlxPoint, ?velocity:FlxPoint):Ball {
		var ball = balls.recycle(Ball);
		if (position != null)
			ball.setCenter(position);
		if (velocity != null)
			ball.velocity.copyFrom(velocity);
		return ball;
	}
	
	public function getPaddle(?speed:Int):Paddle {
		if (speed == null)
			speed = FlxG.width;
		var paddle = paddles.recycle(Paddle);
		paddle.speed = speed;
		return paddle;
	}
	
	public function getWall(x:Float, y:Float, width:Int, height:Int, facing:Int):Wall {
		var wall = walls.recycle(Wall);
		wall.resetWall(x, y, width, height, facing);
		return wall;
	}
	
	public function getDefaultColorSwatch(x:Float = 0, y:Float = 0) {
		return new ColorSwatchSelector(Game.color.list, x, y);
	}
	
}