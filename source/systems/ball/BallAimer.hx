package systems.ball;

import flixel.FlxG;
import objects.Paddle;
import systems.match.Team;
using flixel.util.FlxArrayUtil;

class BallAimer {
	private var paddle:Paddle;
	private var currentTeam:Team;
	private var pushedPaddles:Array<Paddle>;
	private var teamLoop:ArrayLoop<Team>;
	
	public function new() {
		pushedPaddles = new Array<Paddle>();
		teamLoop = new ArrayLoop<Team>();
	}
	
	public function autoPush() {
		teamLoop.setArray(Game.match.teams);
		currentTeam = getFirstTeamToShoot(Game.match.lastScoringTeam);
		teamLoop.setToIndexOf(currentTeam);
		
		for (i in 0...Game.ball.shooter.maxBalls) {
			paddle = getRandomFromTeam(currentTeam, pushedPaddles);
			Game.ball.shooter.push(paddle);
			pushedPaddles.push(paddle);
			currentTeam = teamLoop.next();
			
			if (pushedPaddles.length == getMatchNumPaddles())
				pushedPaddles.clearArray();
		}
		
		paddle = null;
		currentTeam = null;
		pushedPaddles.clearArray();
	}
	
	private inline function getFirstTeamToShoot(?scoringTeam:Team):Team {
		return scoringTeam != null ? scoringTeam : FlxG.random.getObject(Game.match.teams);
	}
	
	private function getRandomFromTeam(team:Team, excludes:Array<Paddle>):Paddle {
		var paddle:Paddle = null;
		do paddle = FlxG.random.getObject(team.paddles).paddle
		while (excludes.contains(paddle));
		return paddle;
	}
	
	private inline function getMatchNumPaddles() {
		return Game.match.team1.paddles.length + Game.match.team2.paddles.length;
	}
	
}