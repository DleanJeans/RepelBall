package;

import systems.BallManager;
import systems.Camera;
import systems.Colors;
import systems.FramerateCounter;
import systems.GoalManager;
import systems.Hoverer;
import systems.Level;
import systems.PaddleExpression;
import systems.Personality;
import systems.WinManager;
import systems.match.Match;
import systems.Pools;
import systems.Positioner;
import systems.Renderer;
import systems.Settings;
import systems.Signals;
import systems.States;
import systems.WallBuilder;
import systems.ballShooter.BallShooter;
import systems.ballShooter.BallShooterAutoPusher;
import systems.collisions.Collision;
import systems.controllers.ControllerList;
import systems.controllers.PaddleMovement;
import ui.Scoreboard;

class Game {
	private static inline var UNIT_LENGTH = 16;
	public static inline function unitLength(times:Float = 1):Int {
		return Std.int(UNIT_LENGTH * times);
	}
	
	public static var level(default, null):Level;
	public static var match(default, null):Match;
	
	public static var settings(default, null):Settings;
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
	public static var goalManager(default, null):GoalManager;
	public static var scoreboard(default, null):Scoreboard;
	public static var color(default, null):Colors;
	public static var walls(default, null):WallBuilder;
	public static var winManager(default, null):WinManager;
	public static var ballManager(default, null):BallManager;
	public static var hoverer(default, null):Hoverer;
	public static var framerateCounter(default, null):FramerateCounter;
	public static var camera(default, null):Camera;
	public static var personality(default, null):Personality;
	public static var paddleExpression(default, null):PaddleExpression;
	
	public static function init() {
		level = new Level();
		match = new Match();
		
		settings = new Settings();
		states = new States();
		renderer = new Renderer();
		collision = new Collision();
		paddleMovement = new PaddleMovement();
		controllers = new ControllerList();
		position = new Positioner();
		pools = new Pools();
		ballShooter = new BallShooter();
		autoPusher = new BallShooterAutoPusher();
		goalManager = new GoalManager();
		scoreboard = new Scoreboard();
		color = new Colors();
		walls = new WallBuilder();
		winManager = new WinManager();
		hoverer = new Hoverer();
		ballManager = new BallManager();
		camera = new Camera();
		personality = new Personality();
		paddleExpression = new PaddleExpression();
		
		signals = new Signals();
		framerateCounter = new FramerateCounter();
	}
	
}