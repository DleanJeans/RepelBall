package systems.match;

import flixel.util.FlxColor;
import objects.Paddle;
import objects.PaddleWrapper;
import objects.Wall;

class Team {
	public var paddles(default, null):Array<PaddleWrapper>;
	public var goal(default, null):Wall;
	
	public var name(default, null):String = "";
	public var color(default, null):FlxColor;
	
	public var score(default, null):Int = 0;
	public var roundScore(default, null):Int = 0;
	
	public var firstPaddle(get, null):Paddle;
	
	public function new() {
		paddles = new Array<PaddleWrapper>();
	}
	
	public function setup(name:String, color:FlxColor) {
		this.name = name;
		this.color = color;
	}
	
	public function setupTeamPosition() {
		for (paddle in paddles)
			Game.paddle.position.putAboveGoal(paddle.paddle, goal);
	}
	
	public function reset() {
		destroyAllPaddles();
		resetRoundScore();
		goal = null;
		score = 0;
	}
	
	private function destroyAllPaddles() {
		for (paddle in paddles)
			paddle.destroy();
		paddles.splice(0, paddles.length);
	}
	
	public inline function resetRoundScore() {
		roundScore = 0;
	}
	
	public inline function addScore() {
		score += 1;
	}
	
	public inline function addRoundScore() {
		roundScore += 1;
	}
	
	public inline function addPaddle(paddle:PaddleWrapper) {
		paddles.push(paddle);
		Game.level.addPaddle(paddle.paddle);
		Game.level.addFace(paddle.face);
	}
	
	public inline function setGoal(goal:Wall) {
		this.goal = goal;
		this.goal.color = color;
	}
	
	inline function get_firstPaddle():Paddle {
		return paddles[0].paddle;
	}
	
}