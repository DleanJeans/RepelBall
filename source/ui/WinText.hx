package ui;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import systems.match.Team;
using flixel.addons.util.position.FlxPosition;

class WinText extends FlxSpriteGroup {	
	public var winner(default, null):FlxText;
	public var won(default, null):FlxText;
	
	public function new() {
		super();
		
		winner = new FlxText(0, 0, Game.settings.MESSAGES_FIELD_WIDTH, Game.messages.winningTeam, 70);
		winner.color = Game.color.winningTeam;
		Game.settings.alignCenter(winner);
		
		won = new FlxText(0, 0, Game.settings.MESSAGES_FIELD_WIDTH, Game.messages.won, 60);
		won.setMidTop(winner.getMidBottom());
		won.alignment = FlxTextAlign.CENTER;
		Game.settings.alignCenter(won);
		
		add(winner);
		add(won);
		
		screenCenter();
	}
	
}