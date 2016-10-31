package systems.collisions;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import objects.Ball;
import objects.Paddle;
import objects.Powerup;
import objects.Wall;
import systems.Stage.BallGroup;
import systems.Stage.PaddleGroup;
import systems.Stage.PowerupGroup;
import systems.Stage.WallGroup;

class Detector extends FlxBasic {
	public var stage(get, never):Stage;
	public var walls(get, never):WallGroup;
	public var paddles(get, never):PaddleGroup;
	public var balls(get, never):BallGroup;
	public var powerups(get, never):PowerupGroup;
	
	public function new() {
		super();
		visible = false;
		Game.stage.addSystem(this);
	}
	
	override public function update(elapsed:Float) {
		detect();
	}
	
	public function routeSignals(ball:Ball, object:FlxObject) {
		switch (Type.getClass(object)) {
			case Ball:
				Game.signals.ball_ball.dispatch(ball, cast object);
			case Wall:
				Game.signals.ball_wall.dispatch(ball, cast object);
			case Paddle:
				Game.signals.ball_paddle.dispatch(ball, cast object);
			case Powerup:
				Game.signals.ball_powerup.dispatch(ball, cast object);
		}
	}
	
	function detect() {
		FlxG.overlap(balls, balls, Game.signals.ball_hit.dispatch, circleToCircle);
		FlxG.overlap(balls, walls, Game.signals.ball_hit.dispatch);
		FlxG.overlap(balls, paddles, Game.signals.ball_hit.dispatch);
		FlxG.overlap(balls, powerups, Game.signals.ball_hit.dispatch);
		FlxG.overlap(paddles, walls, Game.signals.paddle_wall.dispatch);
	}
	
	private inline function circleToCircle(circle:FlxSprite, circle2:FlxSprite):Bool {
		return FlxMath.isDistanceWithin(circle, circle2, circle.width + circle2.width, true);
	}
	
	inline function get_stage():Stage {
		return Game.stage;
	}
	
	inline function get_walls():WallGroup {
		return stage.walls;
	}
	
	inline function get_paddles():PaddleGroup {
		return stage.paddles;
	}
	
	inline function get_balls():BallGroup {
		return stage.balls;
	}
	
	inline function get_powerups():PowerupGroup {
		return stage.powerups;
	}
	
}