package ui;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
using flixel.addons.util.position.FlxPosition;

class RoundScoreText extends FlxSpriteGroup {
	public var score1(default, null):FlxText;
	public var dash(default, null):FlxText;
	public var score2(default, null):FlxText;
	
	public function new() {
		super();
		
		score1 = new FlxText(0, 0, 0, "0", 60);
		dash = new FlxText(0, 0, 0, Game.messages.dashSeparator, 60);
		score2 = new FlxText(0, 0, 0, "0", 60);
		
		updatePosition();
		
		add(score1);
		add(score2);
		add(dash);
		
		Game.level.addUI(this);
		screenCenter();
	}
	
	private function updatePosition() {
		dash.x = score1.getRight();
		score2.x = dash.getRight();
	}
	
	public function updateScores() {
		score1.text = Game.messages.teamRoundScore1;
		score2.text = Game.messages.teamRoundScore2;
		score1.color = Game.color.team1;
		score2.color = Game.color.team2;
		
		updatePosition();
		screenCenter();
	}
	
}