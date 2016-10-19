package systems.collisions;

import flixel.FlxObject;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
using Positioner;

class Handler {
	public var ball_paddle_collision(default, null):Ball_Paddle;
	
	public function new() {
		ball_paddle_collision = new Ball_Paddle();
	}
	
	public inline function ball_paddle(ball:Ball, paddle:Paddle) {
		ball_paddle_collision.update(ball, paddle);
	}
	
	public inline function ball_ball(ball1:Ball, ball2:Ball) {
		FlxObject.separate(ball1, ball2);
	}
	
	public inline function ball_wall(ball:Ball, wall:Wall) {
		FlxObject.separate(ball, wall);
	}
	
	public inline function paddle_wall(paddle:Paddle, wall:Wall) {
		FlxObject.separate(paddle, wall);
	}
}