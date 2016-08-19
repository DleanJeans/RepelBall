package systems;

import flixel.FlxBasic;
import flixel.util.FlxSignal;
import flixel.util.FlxSignal.FlxTypedSignal;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
import systems.Match.Team;

typedef Signal2<T1:FlxBasic, T2:FlxBasic> = FlxTypedSignal<T1->T2->Void>;

class Signals {
	public var ball_ball:Signal2<Ball, Ball> = new Signal2<Ball, Ball>();
	public var ball_wall:Signal2<Ball, Wall> = new Signal2<Ball, Wall>();
	public var ball_paddle:Signal2<Ball, Paddle> = new Signal2<Ball, Paddle>();
	public var paddle_wall:Signal2<Paddle, Wall> = new Signal2<Paddle, Wall>();
	
	public var goal:Signal2<Wall, Ball> = new Signal2<Wall, Ball>();
	public var pauseAfterGoal:FlxSignal = new FlxSignal();
	
	public var matchStart:FlxSignal = new FlxSignal();
	public var matchOver:FlxTypedSignal<Team->Void> = new FlxTypedSignal<Team->Void>();
	
	public var preRoundStart:FlxSignal = new FlxSignal();
	public var roundStart:FlxSignal = new FlxSignal();

	public function new() {}
}