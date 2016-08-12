package systems;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
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

	public function new() {
		super();
		
		walls = new WallGroup();
		paddles = new PaddleGroup();
		balls = new BallGroup();
		
		add(walls);
		add(paddles);
		add(balls);
	}
	
	public inline function addWall(wall:Wall) {
		walls.add(wall);
	}
	
	public inline function addPaddle(paddle:Paddle) {
		paddles.add(paddle);
	}
}