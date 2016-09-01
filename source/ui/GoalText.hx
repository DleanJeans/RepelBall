package ui;

import flixel.FlxG;
import flixel.text.FlxText;
import systems.match.Team;

class GoalText extends FlxText {
	public function new() {
		super(0, 0, FlxG.width * 0.85, "", 70);
		screenCenter();
		alignment = FlxTextAlign.CENTER;
	}
	
	public function updateText() {
		var scoringTeam = Game.match.teamScoredLastRound;
		
		if (scoringTeam != null) {
			text = scoringTeam.name + "\nscored!";
			var start = 0;
			var end = scoringTeam.name.length;
			addFormat(new FlxTextFormat(scoringTeam.color), start, end);
		}
		else {
			text = "Round tie!";
		}
	}
	
}