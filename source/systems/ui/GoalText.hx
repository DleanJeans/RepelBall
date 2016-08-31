package systems.ui;

import flixel.FlxG;
import flixel.text.FlxText;
import systems.match.Team;

class GoalText extends FlxText {
	public function new() {
		super(0, 0, FlxG.width * 0.8, "", 75);
		screenCenter();
		alignment = FlxTextAlign.CENTER;
	}
	
	public function updateText() {
		var scoringTeam = Game.match.teamScoredLastRound;
		
		if (scoringTeam != null) {
			text = scoringTeam.name + "\nscores!";
			color = scoringTeam.color;
		}
		else {
			text = "Round tie!";
			color = Game.color.white;
		}
	}
	
}