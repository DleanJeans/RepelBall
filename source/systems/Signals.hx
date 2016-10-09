package systems;

import flixel.FlxBasic;
import flixel.util.FlxSignal;
import flixel.util.FlxSignal.FlxTypedSignal;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
import systems.Signals.Signal1;
import systems.match.Team;

typedef Signal = FlxSignal;
typedef Signal1<T> = FlxTypedSignal<T->Void>;
typedef Signal2<T1, T2> = FlxTypedSignal<T1->T2->Void>;

class Signals {
	public var ball_hit:Signal2<Ball, Dynamic> = new Signal2<Ball, Dynamic>();
	public var ball_ball:Signal2<Ball, Ball> = new Signal2<Ball, Ball>();
	public var ball_wall:Signal2<Ball, Wall> = new Signal2<Ball, Wall>();
	public var ball_paddle:Signal2<Ball, Paddle> = new Signal2<Ball, Paddle>();
	public var paddle_wall:Signal2<Paddle, Wall> = new Signal2<Paddle, Wall>();
	
	public var ballSpawned:Signal1<Ball> = new Signal1<Ball>();
	
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
		matchStart.add(Game.paddle.expression.updateEyesFacing);
		matchStart.add(Game.paddle.hoverer.startHoveringAllPaddles);
		matchStart.add(preRoundStart.dispatch);
		
		preRoundStart.add(Game.states.resumeState);
		preRoundStart.add(Game.states.countdown);
		preRoundStart.add(Game.level.resetPaddlesPosition);
		preRoundStart.add(Game.paddle.hoverer.resumeAllHovering);
		preRoundStart.add(Game.cometTrail.trail.clearCanvas);
		
		roundStart.add(Game.match.startRound);
		roundStart.add(Game.controllers.revive);
		roundStart.add(Game.ball.shooter.shootInstantly);
		roundStart.add(Game.ball.shooter.revive);
		roundStart.add(Game.ball.pusher.autoPush);
		roundStart.add(Game.sfx.playThemeInGame);
		roundStart.add(Game.cometTrail.enable);
		
		roundEnd.add(Game.match.endRound);
		roundEnd.add(Game.match.addScore);
		roundEnd.add(Game.scoreboard.updateScores);
		roundEnd.add(Game.match.resetRoundScores);
		roundEnd.add(Game.match.checkWin);
		roundEnd.add(Game.match.checkMatchOver);
		roundEnd.add(Game.paddle.hoverer.pauseAllHovering);
		roundEnd.add(Game.controllers.kill);
		roundEnd.add(Game.ball.shooter.kill);
		roundEnd.add(Game.sfx.fadeOutTheme);
		
		postRoundEnd.add(Game.match.startNextRoundOrEndMatch);
		postRoundEnd.add(Game.goalManager.clearGoalStateReference);
		postRoundEnd.add(Game.level.clearBalls);
		postRoundEnd.add(Game.paddle.expression.closeAll);
		postRoundEnd.add(Game.cometTrail.removeAll);
		postRoundEnd.add(Game.cometTrail.disable);
		
		matchOver.add(Game.winManager.triggerWinState);
		
		postMatchOver.add(Game.paddle.squeezer.stopAllTweens);
		postMatchOver.add(Game.states.menu);
		postMatchOver.add(Game.controllers.clear);
		postMatchOver.add(Game.paddle.hoverer.stopHoveringAllPaddles);
		postMatchOver.add(Game.level.paddles.clear);
		postMatchOver.add(Game.match.reset);
		
		ballSpawned.add(Game.cometTrail.addBall);
		
		goalTeam.add(Game.match.addRoundScore);
		goal.add(Game.goalManager.triggerGoalState);
		goal.add(Game.screen.glitch.run);
		
		ball_hit.add(Game.collision.detector.routeSignals);
		ball_hit.add(Game.sfx.playBallHitSound);
		ball_hit.add(Game.ball.fx.popOnCollision);
		ball_hit.add(Game.ball.fx.tweenColor);
		
		ball_ball.add(Game.collision.handler.ball_ball);
		
		ball_wall.add(Game.match.checkGoal);
		ball_wall.add(Game.ball.manager.disableBallSolid);
		ball_wall.add(Game.collision.handler.ball_wall);
		ball_wall.add(Game.screen.shake.ball);
		
		paddle_wall.add(Game.collision.handler.paddle_wall);
		paddle_wall.add(Game.paddle.expression.reattachFace);
		
		ball_paddle.add(Game.collision.handler.ball_paddle);
		ball_paddle.add(Game.ball.manager.increaseBallSpeed);
		ball_paddle.add(Game.paddle.hoverer.knockBackBallSpeed);
	}
}