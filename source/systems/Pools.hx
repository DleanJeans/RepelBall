package systems;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import objects.Ball;
import objects.PaddleWrapper;
import objects.Wall;
import objects.Powerup;
import ui.ColorSwatchSelector;
import ui.LoopSelector;

typedef Pool<T:FlxBasic> = FlxTypedGroup<T>;
typedef BallPool = Pool<Ball>;
typedef PowerupPool = Pool<Powerup>;

class Pools {
	public var balls(default, null):BallPool;
	public var powerups(default, null):PowerupPool;
	
	public function new() {
		balls = new BallPool();
		powerups = new PowerupPool();
	}
	
	public inline function cloneBall(ball:Ball):Ball {
		return ball.cloneBall();
	}
	
	public function getBall(?position:FlxPoint, ?velocity:FlxPoint):Ball {
		var ball = balls.recycle(Ball);
		ball.resetBall();
		if (position != null)
			ball.setCenter(position);
		if (velocity != null)
			ball.velocity.copyFrom(velocity);
		return ball;
	}
	
	public function getPowerup(type:Int, ?position:FlxPoint):Powerup {
		var powerup = powerups.recycle(Powerup);
		powerup.setType(type);
		if (position != null) {
			powerup.setCenter(position);
			position.putWeak();
		}
		powerup.startLifeTimer();
		return powerup;
	}
	
	public inline function getPaddle():PaddleWrapper {
		var paddle = new PaddleWrapper();
		return paddle;
	}
	
	public inline function getWall(x:Float, y:Float, width:Int, height:Int, facing:Int):Wall {
		var wall = new Wall();
		wall.resetWall(x, y, width, height, facing);
		return wall;
	}
	
	public inline function getDefaultColorSwatch(x:Float = 0, y:Float = 0):ColorSwatchSelector {
		return new ColorSwatchSelector(Game.color.list, x, y, Settings.COLOR_SWATCH_SIZE, Settings.COLOR_SWATCH_SIZE);
	}
	
	public inline function getLoopSelector(label:String, values:Array<Dynamic>, labelFieldWidth:Int = 175):LoopSelector {
		return new LoopSelector(0, 0, 300, Settings.LOOP_SELECTOR_HEIGHT, label, values, labelFieldWidth);
	}
	
}