package systems;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import objects.Ball;
import objects.Paddle;
import objects.Wall;

typedef Group<T:FlxSprite> = FlxTypedSpriteGroup<T>;
typedef WallGroup = Group<Wall>;
typedef PaddleGroup = Group<Paddle>;
typedef BallGroup = Group<Ball>;

class Level extends FlxGroup {
	public var walls(default, null):WallGroup;
	public var paddles(default, null):PaddleGroup;
	public var balls(default, null):BallGroup;
	
	public var uis(default, null):FlxSpriteGroup;

	public function new() {
		super();
		
		walls = new WallGroup();
		paddles = new PaddleGroup();
		balls = new BallGroup();
		uis = new FlxSpriteGroup();
		
		add(walls);
		add(paddles);
		add(balls);
		add(uis);
	}
	
	public function resetLevel() {
		balls.kill();
		balls.clear();
		balls.revive();
		
		paddles.forEach(Paddle.resetPaddlePosition);
	}
	
	public inline function addWall(wall:Wall) {
		walls.add(wall);
	}
	
	public inline function addPaddle(paddle:Paddle) {
		paddles.add(paddle);
	}
	
	public inline function addBall(ball:Ball) {
		balls.add(ball);
	}
	
	public inline function removeBall(ball:Ball) {
		balls.remove(ball);
	}
	
	public inline function addUI(ui:FlxSprite) {
		uis.add(ui);
	}
	
	public inline function removeUI(ui:FlxSprite) {
		uis.remove(ui);
	}
}