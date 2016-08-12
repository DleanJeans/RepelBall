package systems;

import flixel.FlxBasic;
import flixel.util.FlxSignal.FlxTypedSignal;
import objects.Ball;
import objects.Paddle;
import objects.Wall;

typedef CollisionSignal<T1:FlxBasic, T2:FlxBasic> = FlxTypedSignal<T1->T2->Void>;

class Signals {
	public var ball_ball:CollisionSignal<Ball, Ball> = new CollisionSignal<Ball, Ball>();
	public var ball_wall:CollisionSignal<Ball, Wall> = new CollisionSignal<Ball, Wall>();
	public var ball_paddle:CollisionSignal<Ball, Paddle> = new CollisionSignal<Ball, Paddle>();
	public var paddle_wall:CollisionSignal<Paddle, Wall> = new CollisionSignal<Paddle, Wall>();

	public function new() {}
}