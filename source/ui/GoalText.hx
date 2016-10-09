package ui;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import systems.match.Team;
using Positioner;

class GoalText extends FlxSpriteGroup {
	public var scoringTeam(default, null):FlxText;
	public var scored(default, null):FlxText;
	
	public function new() {
		super();
		
		scoringTeam = new FlxText(0, 0, Game.settings.MESSAGES_FIELD_WIDTH, "", 70);
		Game.settings.alignCenter(scoringTeam);
		
		scored = new FlxText(0, 0, Game.settings.MESSAGES_FIELD_WIDTH, "", 60);
		scored.setMidTop(scoringTeam.getMidBottom());
		Game.settings.alignCenter(scored);
		
		add(scoringTeam);
		add(scored);
		
		screenCenter();
	}
	
	public function updateText() {
		if (Game.messages.scoringTeam != "") {
			scoringTeam.text = Game.messages.scoringTeam;
			scored.text = Game.messages.scored;
			
			scoringTeam.color = Game.color.scoringTeam;
		}
		else {
			scoringTeam.text = Game.messages.roundTie;
		}
	}
	
}