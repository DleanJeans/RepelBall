package systems.ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import objects.Ball;
import objects.Wall;

using flixel.addons.util.position.FlxPosition;

class Scoreboard extends FlxSpriteGroup {
	public var background1:FlxSprite;
	public var background2:FlxSprite;
	
	public var score1:FlxText;
	public var score2:FlxText;

	public function new() {
		super();
		
		background1 = new FlxSprite();
		background2 = new FlxSprite();
		score1 = new FlxText(0, 0, 0, "00", 30);
		score2 = new FlxText(0, 0, 0, "00", 30);
		
		background1.makeGraphic(cast score1.width * 1.25, cast score1.height * 1.25);
		background2.makeGraphic(cast score2.width * 1.25, cast score2.height * 1.25);
		background2.setTopLeft(background1.getTopRight());
		
		add(background1);
		add(background2);
		add(score1);
		add(score2);
		
		background1.color = Game.colors.green;
		background2.color = Game.colors.blue;
		
		screenCenter(FlxAxes.X);
	}
	
	public function updateScores() {
		score1.text = Std.string(Game.match.team1.score);
		score2.text = Std.string(Game.match.team2.score);
		
		updateTextPosition();
	}
	
	private function updateTextPosition() {
		score1.setCenter(background1.getCenter());
		score2.setCenter(background2.getCenter());
	}
	
}