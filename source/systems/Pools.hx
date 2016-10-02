package systems;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import objects.Ball;
import objects.PaddleWrapper;
import objects.Wall;
import ui.ColorSwatchSelector;
import ui.LoopSelector;
using flixel.addons.util.position.FlxPosition;

typedef Pool<T:FlxBasic> = FlxTypedGroup<T>;
typedef BallPool = Pool<Ball>;

class Pools {
	public var balls(default, null):BallPool;
	
	public function new() {
		balls = new BallPool();
	}
	
	public function getBall(?position:FlxPoint, ?velocity:FlxPoint):Ball {
		var ball = balls.recycle(Ball);
		ball.resetSpeed();
		ball.resetColor();
		ball.setHitGoal(false);
		if (position != null)
			ball.setCenter(position);
		if (velocity != null)
			ball.velocity.copyFrom(velocity);
		return ball;
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
		return new ColorSwatchSelector(Game.color.list, x, y, Game.settings.COLOR_SWATCH_SIZE, Game.settings.COLOR_SWATCH_SIZE);
	}
	
	public inline function getLoopSelector(label:String, values:Array<Dynamic>, labelFieldWidth:Int = 175):LoopSelector {
		return new LoopSelector(0, 0, 300, Game.settings.LOOP_SELECTOR_HEIGHT, label, values, labelFieldWidth);
	}
	
}