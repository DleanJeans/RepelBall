package;

import systems.AnyInput;
import systems.Colors;
import systems.FramerateCounter;
import systems.GoalManager;
import systems.ball.BallSystems;
import systems.Level;
import systems.Messages;
import systems.SoundFX;
import systems.WinManager;
import systems.match.Match;
import systems.Pools;
import systems.Positioner;
import systems.Renderer;
import systems.Settings;
import systems.Signals;
import systems.States;
import systems.WallBuilder;
import systems.collisions.Collision;
import systems.controllers.ControllerList;
import systems.controllers.PaddleMovement;
import systems.paddle.PaddleSystems;
import ui.Scoreboard;

class Game {
	private static inline var UNIT_LENGTH = 24;
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
	public static var goalManager(default, null):GoalManager;
	public static var scoreboard(default, null):Scoreboard;
	public static var color(default, null):Colors;
	public static var walls(default, null):WallBuilder;
	public static var winManager(default, null):WinManager;
	public static var framerateCounter(default, null):FramerateCounter;
	public static var sfx(default, null):SoundFX;
	public static var anyInput(default, null):AnyInput;
	public static var messages(default, null):Messages;
	public static var ball(default, null):BallSystems;
	public static var paddle(default, null):PaddleSystems;
	
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
		goalManager = new GoalManager();
		scoreboard = new Scoreboard();
		color = new Colors();
		walls = new WallBuilder();
		winManager = new WinManager();
		sfx = new SoundFX();
		anyInput = new AnyInput();
		messages = new Messages();
		ball = new BallSystems();
		paddle = new PaddleSystems();
		
		signals = new Signals();
		framerateCounter = new FramerateCounter();
	}
	
}