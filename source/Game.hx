package;

import systems.AnyInput;
import systems.Colors;
import systems.FramerateCounter;
import systems.GoalManager;
import systems.Messages;
import systems.Pools;
import systems.Renderer;
import systems.Save;
import systems.Signals;
import systems.SoundFX;
import systems.Speed;
import systems.Stage;
import systems.States;
import systems.Tweens;
import systems.WallBuilder;
import systems.Watermark;
import systems.WinManager;
import systems.ball.BallSystems;
import systems.collisions.Collision;
import systems.controllers.ControllerList;
import systems.match.Match;
import systems.paddle.PaddleSystems;
import systems.powerups.PowerupSystems;
import systems.screen.ScreenSystems;
import systems.testing.ClickSpawner;
import systems.testing.TestingSystems;
import systems.timers.Timers;
import systems.trail.CometTrailWrapper;
import ui.Notifier;
import ui.Scoreboard;
import ui.TimeBoard;

class Game {
	public static var stage(default, null):Stage;
	public static var match(default, null):Match;
	
	public static var signals(default, null):Signals;
	public static var states(default, null):States;
	public static var renderer(default, null):Renderer;
	public static var collision(default, null):Collision;
	public static var controllers(default, null):ControllerList;
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
	public static var tween(default, null):Tweens;
	public static var cometTrail(default, null):CometTrailWrapper;
	public static var screen(default, null):ScreenSystems;
	public static var speed(default, null):Speed;
	public static var save(default, null):Save;
	public static var powerups(default, null):PowerupSystems;
	public static var testing(default, null):TestingSystems;
	public static var notifier(default, null):Notifier;
	public static var watermark(default, null):Watermark;
	public static var timers(default, null):Timers;
	public static var timeBoard(default, null):TimeBoard;
	public static var clickSpawner(default, null):ClickSpawner;
	
	public static function init() {
		Settings.apply();
		UI.init();
		
		stage = new Stage();
		match = new Match();
		
		states = new States();
		renderer = new Renderer();
		collision = new Collision();
		controllers = new ControllerList();
		pools = new Pools();
		goalManager = new GoalManager();
		color = new Colors();
		walls = new WallBuilder();
		winManager = new WinManager();
		sfx = new SoundFX();
		anyInput = new AnyInput();
		messages = new Messages();
		ball = new BallSystems();
		paddle = new PaddleSystems();
		tween = new Tweens();
		cometTrail = new CometTrailWrapper();
		screen = new ScreenSystems();
		speed = new Speed();
		save = new Save();
		powerups = new PowerupSystems();
		watermark = new Watermark();
		timers = new Timers();
		clickSpawner = new ClickSpawner();
		
		scoreboard = new Scoreboard();
		notifier = new Notifier();
		timeBoard = new TimeBoard();
		
		framerateCounter = new FramerateCounter();
		signals = new Signals();
		testing = new TestingSystems();
	}
	
}