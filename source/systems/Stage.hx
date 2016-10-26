package systems;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import objects.Ball;
import objects.Paddle;
import objects.Powerup;
import objects.Wall;
import objects.personality.Face;
import systems.Stage.FaceGroup;

typedef Group<T:FlxSprite> = FlxTypedGroup<T>;
typedef WallGroup = Group<Wall>;
typedef PaddleGroup = Group<Paddle>;
typedef FaceGroup = Group<Face>;
typedef BallGroup = Group<Ball>;
typedef PowerupGroup = Group<Powerup>;

class Stage extends FlxGroup {
	public var systems(default, null):FlxGroup;
	public var walls(default, null):WallGroup;
	public var paddles(default, null):PaddleGroup;
	public var faces(default, null):FaceGroup;
	public var particles(default, null):FlxGroup;
	public var balls(default, null):BallGroup;
	public var powerups(default, null):PowerupGroup;
	
	public var uis(default, null):FlxSpriteGroup;

	public function new() {
		super();
		
		systems = new FlxGroup();
		walls = new WallGroup();
		paddles = new PaddleGroup();
		faces = new FaceGroup();
		particles = new FlxGroup();
		balls = new BallGroup();
		powerups = new PowerupGroup();
		
		uis = new FlxSpriteGroup();
		
		add(systems);
		add(walls);
		add(paddles);
		add(particles);
		add(faces);
		add(balls);
		add(powerups);
		
		add(uis);
	}
	
	public function resetPaddlesPosition() {
		paddles.forEach(Game.paddle.position.resetPosition);
	}
	
	public inline function clearBalls() {
		clearGroup(cast balls);
	}
	
	public inline function clearPowerups() {
		clearGroup(cast powerups);
	}
	
	private inline function clearGroup(group:FlxGroup) {
		group.kill();
		group.clear();
		group.revive();
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
	
	public inline function addParticle(particle:FlxBasic) {
		particles.add(particle);
	}
	
	public inline function addBall(ball:Ball) {
		balls.add(ball);
	}
	
	public inline function removeBall(ball:Ball) {
		balls.remove(ball);
	}
	
	public inline function addPowerup(powerup:Powerup) {
		powerups.add(powerup);
	}
	
	public inline function removePowerup(powerup:Powerup) {
		powerups.remove(powerup);
	}
	
	public inline function addUI(ui:FlxSprite) {
		uis.add(ui);
	}
	
	public inline function removeUI(ui:FlxSprite) {
		uis.remove(ui);
	}
}