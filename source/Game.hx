package;

import flixel.FlxObject;
import systems.GoalHandler;
import systems.Level;
import systems.Match;
import systems.Pools;
import systems.Positioner;
import systems.Renderer;
import systems.Signals;
import systems.States;
import systems.ballShooter.BallShooter;
import systems.ballShooter.BallShooterAutoPusher;
import systems.collisions.Collision;
import systems.controllers.ControllerList;
import systems.controllers.PaddleMovement;
import systems.ui.Scoreboard;

class Game {
	private static inline var UNIT_LENGTH = 16;
	public static inline function unitLength(times:Float = 1):Int {
		return cast UNIT_LENGTH * times;
	}
	
	public static var level(default, null):Level;
	public static var match(default, null):Match;
	
	public static var signals(default, null):Signals;
	public static var states(default, null):States;
	public static var renderer(default, null):Renderer;
	public static var collision(default, null):Collision;
	public static var paddleMovement(default, null):PaddleMovement;
	public static var controllers(default, null):ControllerList;
	public static var position(default, null):Positioner;
	public static var pools(default, null):Pools;
	public static var ballShooter(default, null):BallShooter;
	public static var autoPusher(default, null):BallShooterAutoPusher;
	public static var goalHandler(default, null):GoalHandler;
	public static var scoreboard(default, null):Scoreboard;
	
	public static function init() {
		signals = new Signals();
		FlxObject.SEPARATE_BIAS = unitLength();
		
		states = new States();
		renderer = new Renderer();
		collision = new Collision();
		paddleMovement = new PaddleMovement();
		controllers = new ControllerList();
		position = new Positioner();
		pools = new Pools();
		ballShooter = new BallShooter();
		autoPusher = new BallShooterAutoPusher();
		goalHandler = new GoalHandler();
		scoreboard = new Scoreboard();
	}
	
	public static inline function startNewLevel() {
		level = new Level();
	}
	
	public static inline function startNewMatch(scoreToWin:Int = 5) {
		match = new Match(scoreToWin);
	}
	
	public static function anyNull(objects:Array<Dynamic>) {
		for (o in objects) {
            if (o == null)
                return true;
        }
        return false;
	}
}