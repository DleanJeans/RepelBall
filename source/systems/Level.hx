package systems;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
import objects.personality.Face;
import systems.Level.FaceGroup;

typedef Group<T:FlxSprite> = FlxTypedSpriteGroup<T>;
typedef WallGroup = Group<Wall>;
typedef PaddleGroup = Group<Paddle>;
typedef FaceGroup = Group<Face>;
typedef BallGroup = Group<Ball>;

class Level extends FlxGroup {
	public var systems(default, null):FlxGroup;
	public var walls(default, null):WallGroup;
	public var paddles(default, null):PaddleGroup;
	public var faces(default, null):FaceGroup;
	public var balls(default, null):BallGroup;
	
	public var uis(default, null):FlxSpriteGroup;

	public function new() {
		super();
		
		systems = new FlxGroup();
		walls = new WallGroup();
		paddles = new PaddleGroup();
		faces = new FaceGroup();
		balls = new BallGroup();
		uis = new FlxSpriteGroup();
		
		add(systems);
		add(walls);
		add(paddles);
		add(faces);
		add(balls);
		add(uis);
	}
	
	public function resetPaddlesPosition() {
		paddles.forEach(Game.position.resetPaddlePosition);
	}
	
	public function clearBalls() {
		balls.kill();
		balls.clear();
		balls.revive();
	}
	
	public inline function addSystem(system:FlxBasic) {
		systems.add(system);
	}
	
	public inline function addWall(wall:Wall) {
		walls.add(wall);
	}
	
	public inline function addPaddle(paddle:Paddle) {
		paddles.add(paddle);
	}
	
	public inline function addFace(face:Face) {
		faces.add(face);
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