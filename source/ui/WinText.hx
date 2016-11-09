package ui;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import systems.match.Team;

class WinText extends FlxSpriteGroup {	
	public var winner(default, null):FlxText;
	public var won(default, null):FlxText;
	
	public function new() {
		super();
		
		winner = new FlxText(0, 0, UI.message.fieldWidth, Game.messages.winningTeam, 70);
		winner.color = Game.color.winningTeam;
		Settings.alignCenter(winner);
		
		won = new FlxText(0, 0, UI.message.fieldWidth, Game.messages.won, 60);
		won.setMidTop(winner.getMidBottom());
		won.alignment = FlxTextAlign.CENTER;
		Settings.alignCenter(won);
		
		add(winner);
		add(won);
		
		screenCenter();
	}
	
}