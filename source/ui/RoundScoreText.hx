package ui;

import flixel.FlxG;
import flixel.text.FlxText;

class RoundScoreText extends FlxText {
	public function new() {
		super(0, 0, FlxG.width, "0 - 0", 60);
		
		alignment = FlxTextAlign.CENTER;
		Game.level.addUI(this);
		screenCenter();
	}
	
	public function updateScores() {
		var score1 = Game.match.team1.roundScore;
		var score2 = Game.match.team2.roundScore;
		
		text = '$score1 - $score2';
	}
	
}