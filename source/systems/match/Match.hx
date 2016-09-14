package systems.match;

import objects.Ball;
import objects.Wall;

class Match {
	public var team1(default, null):Team;
	public var team2(default, null):Team;
	public var teams(default, null):Array<Team>;
	public var scoreToWin:Int = 5;
	public var maxBalls(get, set):Int;
	
	public var winningTeam(default, null):Team;
	public var lastScoringTeam(default, null):Team;
	
	public var started(default, null):Bool = false;
	public var over(default, null):Bool = false;
	public var roundStarted(default, null):Bool = false;
	public var roundEnded(default, null):Bool = false;

	public function new() {
		team1 = new Team();
		team2 = new Team();
		teams = [team1, team2];
	}
	
	public inline function start() {
		started = true;
		over = false;
	}
	
	public inline function startRound() {
		roundStarted = true;
		roundEnded = false;
	}
	
	public inline function endRound() {
		roundStarted = false;
		roundEnded = true;
	}
	
	public inline function end() {
		started = false;
		over = true;
	}
	
	public inline function setupTeamsPosition() {
		team1.setupTeamPosition();
		team2.setupTeamPosition();
	}
	
	public function reset() {
		scoreToWin = 3;
		winningTeam = null;
		lastScoringTeam = null;
		
		team1.reset();
		team2.reset();
	}
	
	public function addScore() {
		if (team1.roundScore > team2.roundScore) {
			team1.addScore();
			lastScoringTeam = team1;
		}
		else if (team1.roundScore < team2.roundScore) {
			team2.addScore();
			lastScoringTeam = team2;
		}
		else lastScoringTeam = null;
	}
	
	public function resetRoundScores() {
		team1.resetRoundScore();
		team2.resetRoundScore();
	}
	
	public function checkGoal(ball:Ball, goal:Wall) {
		var scoringTeam = getScoringTeam(goal);
		if (scoringTeam != null) {
			Game.signals.goalTeam.dispatch(scoringTeam);
			Game.signals.goal.dispatch();
			Game.signals.goalBall.dispatch(ball);
		}
	}
	
	public function addRoundScore(scoringTeam:Team) {
		if (scoringTeam != null)
			scoringTeam.addRoundScore();
	}
	
	private function getScoringTeam(goal:Wall):Team {
		if (goal == team1.goal)
			return team2;
		else if (goal == team2.goal)
			return team1;
		else return null;
	}
	
	public function checkWin() {
		for (team in teams) {
			if (team.score >= scoreToWin)
				winningTeam = team;
		}
	}
	
	public function checkMatchOver() {
		if (winningTeam != null)
			end();
	}
	
	public function startNextRoundOrEndMatch() {
		if (over)
			Game.signals.matchOver.dispatch();
		else Game.signals.preRoundStart.dispatch();
	}
	
	function get_maxBalls():Int {
		return Game.ball.shooter.maxBalls;
	}
	
	function set_maxBalls(newMaxBalls:Int):Int {
		return Game.ball.shooter.maxBalls = newMaxBalls;
	}
	
}