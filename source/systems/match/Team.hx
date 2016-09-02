package systems.match;

import flixel.util.FlxColor;
import objects.Paddle;
import objects.Wall;

class Team {
	public var paddles(default, null):Array<Paddle>;
	public var goal(default, null):Wall;
	
	public var name(default, null):String = "";
	public var color(default, null):FlxColor;
	
	public var score(default, null):Int = 0;
	public var roundScore(default, null):Int = 0;
	
	public function new() {
		paddles = new Array<Paddle>();
	}
	
	public function setup(name:String, color:FlxColor) {
		this.name = name;
		this.color = color;
	}
	
	public function setupTeamPosition() {
		for (paddle in paddles)
			Game.position.putPaddleOnGoal(paddle, goal);
	}
	
	public function reset() {
		paddles.splice(0, paddles.length);
		goal = null;
		resetRoundScore();
		score = 0;
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
	
	public inline function addPaddle(paddle:Paddle) {
		paddles.push(paddle);
		Game.level.addPaddle(paddle);
	}
	
	public inline function setGoal(goal:Wall) {
		this.goal = goal;
		this.goal.color = color;
	}
	
}