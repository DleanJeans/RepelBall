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

	public function new() {
		matchStart.add(Game.scoreboard.updateColors);
		
		ball_ball.add(Game.collision.handler.ball_ball);
		ball_wall.add(Game.collision.handler.ball_wall);
		paddle_wall.add(Game.collision.handler.paddle_wall);
		ball_paddle.add(Game.collision.handler.ball_paddle.update);
		ball_wall.add(Game.match.checkGoal);
		
		goal.add(Game.goalHandler.startMultiGoalTimer);
		goal.add(Game.goalHandler.killBall);
		goal.add(Game.match.checkWin);
		
		pauseAfterGoal.add(Game.states.goal);
		
		preRoundStart.add(Game.states.countdown);
		preRoundStart.add(Game.level.resetLevel);
		preRoundStart.add(Game.scoreboard.updateScores);
		
		roundStart.add(Game.ballShooter.setElapsedToSpawnInstantly);
		roundStart.add(Game.autoPusher.autoPush);
	}
}