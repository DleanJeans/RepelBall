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
		var team1 = Game.match.team1;
		var team2 = Game.match.team2;
		var score1 = team1.roundScore;
		var score2 = team2.roundScore;
		
		text = '$score1 - $score2';
		clearFormats();
		addFormat(new FlxTextFormat(team1.color), 0, 2);
		addFormat(new FlxTextFormat(team2.color), 4);
	}
	
}