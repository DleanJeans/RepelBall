package systems;

import flixel.FlxBasic;
import flixel.util.FlxSignal;
import flixel.util.FlxSignal.FlxTypedSignal;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
import systems.match.Team;
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
	public var goalTeam:Signal1<Team> = new Signal1<Team>();
	
	public var matchStart:Signal = new Signal();
	public var matchOver:Signal = new Signal();
	public var postMatchOver:Signal = new Signal();
	
	public var preRoundStart:Signal = new Signal();
	public var roundStart:Signal = new Signal();
	public var roundEnd:Signal = new Signal();
	public var postRoundEnd:Signal = new Signal();

	public function new() {
		matchStart.add(Game.match.start);
		matchStart.add(Game.scoreboard.updateColors);
		matchStart.add(Game.scoreboard.updateScores);
		matchStart.add(Game.match.setupTeamsPosition);
		matchStart.add(preRoundStart.dispatch);
		
		preRoundStart.add(Game.states.countdown);
		preRoundStart.add(Game.level.resetPaddlesPosition);
		
		roundStart.add(Game.match.startRound);
		roundStart.add(Game.ballShooter.spawnInstantly);
		roundStart.add(Game.autoPusher.autoPush);		
		
		roundEnd.add(Game.match.endRound);
		roundEnd.add(Game.match.addScore);
		roundEnd.add(Game.scoreboard.updateScores);
		roundEnd.add(Game.match.resetRoundScores);
		roundEnd.add(Game.match.checkWin);
		roundEnd.add(Game.match.checkMatchOver);
		
		postRoundEnd.add(Game.match.startNextRoundOrEndMatch);
		postRoundEnd.add(Game.goalManager.clearGoalStateReference);
		postRoundEnd.add(Game.level.clearBalls);
		
		matchOver.add(Game.winManager.triggerWinState);
		
		postMatchOver.add(Game.level.clearPaddles);
		postMatchOver.add(Game.match.reset);
		postMatchOver.add(Game.states.menu);
		postMatchOver.add(Game.controllers.removeAll);
		
		goalTeam.add(Game.match.addRoundScore);
		goal.add(Game.goalManager.triggerGoalState);
		goalBall.add(Game.goalManager.killBall);
		
		ball_ball.add(Game.collision.handler.ball_ball);
		ball_wall.add(Game.collision.handler.ball_wall);
		paddle_wall.add(Game.collision.handler.paddle_wall);
		ball_paddle.add(Game.ballManager.changeBallColor);
		ball_paddle.add(Game.ballManager.increaseBallSpeed);
		ball_paddle.add(Game.collision.handler.ball_paddle);
		ball_wall.add(Game.match.checkGoal);
	}
}