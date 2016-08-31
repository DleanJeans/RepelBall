package systems;

import flixel.FlxBasic;
import flixel.util.FlxSignal;
import flixel.util.FlxSignal.FlxTypedSignal;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
import systems.Match.Team;
import systems.Signals.Signal1;

typedef Signal = FlxSignal;
typedef Signal1<T> = FlxTypedSignal<T->Void>;
typedef Signal2<T1, T2> = FlxTypedSignal<T1->T2->Void>;

class Signals {
	public var ball_ball:Signal2<Ball, Ball> = new Signal2<Ball, Ball>();
	public var ball_wall:Signal2<Ball, Wall> = new Signal2<Ball, Wall>();
	public var ball_paddle:Signal2<Ball, Paddle> = new Signal2<Ball, Paddle>();
	public var paddle_wall:Signal2<Paddle, Wall> = new Signal2<Paddle, Wall>();
	
	public var goal:Signal = new Signal();
	public var goalBall:Signal1<Ball> = new Signal1<Ball>();
	
	public var matchStart:Signal = new Signal();
	public var matchOver:Signal1<Team> = new Signal1<Team>();
	
	public var preRoundStart:Signal = new Signal();
	public var roundStart:Signal = new Signal();
	public var roundEnd:Signal = new Signal();

	public function new() {
		matchStart.add(Game.scoreboard.updateColors);
		
		ball_ball.add(Game.collision.handler.ball_ball);
		ball_wall.add(Game.collision.handler.ball_wall);
		paddle_wall.add(Game.collision.handler.paddle_wall);
		ball_paddle.add(Game.collision.handler.ball_paddle.update);
		ball_wall.add(Game.match.checkGoal);
		
		goal.add(Game.goalHandler.triggerGoalState);
		goalBall.add(Game.goalHandler.killBall);
		//goal.add(Game.match.checkWin);
		
		preRoundStart.add(Game.goalHandler.closeGoalState);
		preRoundStart.add(Game.states.countdown);
		preRoundStart.add(Game.level.resetLevel);
		preRoundStart.add(Game.scoreboard.updateScores);
		
		roundStart.add(Game.ballShooter.setElapsedToSpawnInstantly);
		roundStart.add(Game.autoPusher.autoPush);
		
		roundEnd.add(Game.match.plusScore);
	}
}