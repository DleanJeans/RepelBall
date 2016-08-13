package systems.collisions;

import flixel.FlxG;
import objects.Ball;
import objects.Paddle;
import objects.Wall;

class Handler {
	public function new() {
		Game.signals.ball_ball.add(ball_ball);
		Game.signals.ball_wall.add(ball_wall);
		Game.signals.ball_paddle.add(ball_paddle);
		Game.signals.paddle_wall.add(paddle_wall);
	}
	
	public inline function ball_ball(ball:Ball, ball:Ball) {
		FlxG.collide(ball, ball);
	}
	
	public inline function ball_wall(ball:Ball, wall:Wall) {
		FlxG.collide(ball, wall);
	}
	
	public inline function ball_paddle(ball:Ball, paddle:Paddle) {
		paddle.immovable = true;
		FlxG.collide(ball, paddle);
		paddle.immovable = false;
	}
	
	public inline function paddle_wall(paddle:Paddle, wall:Wall) {
		FlxG.collide(paddle, wall);
	}
}