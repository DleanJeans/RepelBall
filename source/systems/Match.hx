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
	
	public var gameOver(get, null):Bool;
	public var winningTeam(default, null):Team;

	public function new(scoreToWin:Int = 5) {
		this.scoreToWin = scoreToWin;
		
		team1 = new Team();
		team2 = new Team();
		teams = [team1, team2];
		
		Game.signals.ball_wall.add(checkGoal);
		Game.signals.goal.add(checkWin);
	}
	
	private function checkGoal(ball:Ball, goal:Wall) {
		var scoreTeam = getScoringTeam(goal);
		if (scoreTeam != null) {
			scoreTeam.plusScore();
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
	
	private function checkWin(goal:Wall, ball:Ball) {
		if (team1.goal != team2.goal)
			return;
		
		for (team in teams) {
			if (team.score >= scoreToWin) {
				winningTeam = team;
				Game.signals.gameOver.dispatch(winningTeam);
			}
		}
	}
	
	private function shootNewBall(goal:Wall, ball:Ball) {
		var scoringTeam = getScoringTeam(goal);
		Game.ballShooter.push(scoringTeam.paddles[0]);
	}
	
	function get_gameOver():Bool {
		return winningTeam != null;
	}
	
}

class Team {
	public var paddles(default, null):Array<Paddle>;
	public var score(default, null):Int = 0;
	public var goal(default, null):Wall;
	
	public function new() {
		paddles = new Array<Paddle>();
	}
	
	public function destroy() {
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