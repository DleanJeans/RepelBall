package ui;

import flixel.FlxG;
import flixel.text.FlxText;
import systems.match.Team;

class WinText extends FlxText {	
	public function new() {
		super(0, 0, FlxG.width * 0.85, "", 70);
		screenCenter();
		alignment = FlxTextAlign.CENTER;
	}
	
	public function updateText() {
		var winningTeam = Game.match.winningTeam;
		
		text = winningTeam.name + "\nwon!";
		var start = 0;
		var end = winningTeam.name.length;
		addFormat(new FlxTextFormat(winningTeam.color), start, end);
	}
	
}