package systems.collisions;

import flixel.FlxG;
import flixel.FlxObject;
import objects.Ball;
import objects.Paddle;
import objects.Powerup;
import objects.Wall;
import systems.Level.BallGroup;
import systems.Level.PaddleGroup;
import systems.Level.PowerupGroup;
import systems.Level.WallGroup;

class Detector {
	public var level(get, never):Level;
	public var walls(get, never):WallGroup;
	public var paddles(get, never):PaddleGroup;
	public var balls(get, never):BallGroup;
	public var powerups(get, never):PowerupGroup;
	
	public function new() {
		FlxG.signals.postUpdate.add(update);
	}
	
	public function update() {
		if (level != null)
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
		FlxG.overlap(balls, balls, Game.signals.ball_hit.dispatch);
		FlxG.overlap(balls, walls, Game.signals.ball_hit.dispatch);
		FlxG.overlap(balls, paddles, Game.signals.ball_hit.dispatch);
		FlxG.overlap(balls, powerups, Game.signals.ball_hit.dispatch);
		FlxG.overlap(paddles, walls, Game.signals.paddle_wall.dispatch);
	}
	
	inline function get_level():Level {
		return Game.level;
	}
	
	inline function get_walls():WallGroup {
		return level.walls;
	}
	
	inline function get_paddles():PaddleGroup {
		return level.paddles;
	}
	
	inline function get_balls():BallGroup {
		return level.balls;
	}
	
	inline function get_powerups():PowerupGroup {
		return level.powerups;
	}
	
}