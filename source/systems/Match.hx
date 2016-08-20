package systems;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
import systems.Match.Team;

class Match {
	public var team1(default, null):Team;
	public var team2(default, null):Team;
	public var teams(default, null):Array<Team>;
	public var scoreToWin(default, null):Int;
	
	public var winningTeam(default, null):Team;
	public var lastScoringTeam(default, null):Team;

	public function new(scoreToWin:Int = 5) {
		this.scoreToWin = scoreToWin;
		
		team1 = new Team();
		team2 = new Team();
		teams = [team1, team2];
	}
	
	public function reset() {
		scoreToWin = 0;
		winningTeam = null;
		lastScoringTeam = null;
		
		team1.reset();
		team2.reset();
	}
	
	public function checkGoal(ball:Ball, goal:Wall) {
		var scoringTeam = getScoringTeam(goal);
		if (scoringTeam != null) {
			lastScoringTeam = scoringTeam;
			scoringTeam.plusScore();
			Game.signals.goal.dispatch(goal, ball);
		}
	}
	
	private function getScoringTeam(goal:Wall):Team {
		if (goal == team1.goal)
			return team2;
		else if (goal == team2.goal)
			return team1;
		else return null;
	}
	
	public function checkWin(goal:Wall, ball:Ball) {
		if (team1.goal != team2.goal)
			return;
		
		for (team in teams) {
			if (team.score >= scoreToWin) {
				winningTeam = team;
				Game.signals.matchOver.dispatch(winningTeam);
			}
		}
	}
	
}

class Team {
	public var paddles(default, null):Array<Paddle>;
	public var score(default, null):Int = 0;
	public var goal(default, null):Wall;
	
	public function new() {
		paddles = new Array<Paddle>();
	}
	
	public function reset() {
		paddles.splice(0, paddles.length);
		goal = null;
	}
	
	public inline function plusScore(points:Int = 1) {
		score += points;
	}
	
	public inline function addPaddle(paddle:Paddle) {
		paddles.push(paddle);
	}
	
	public inline function setGoal(goal:Wall) {
		this.goal = goal;
	}
	
}