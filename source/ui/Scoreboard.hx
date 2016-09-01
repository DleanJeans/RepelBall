package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import objects.Ball;
import objects.Wall;

using flixel.addons.util.position.FlxPosition;

class Scoreboard extends FlxSpriteGroup {
	public var background1(default, null):FlxSprite;
	public var background2(default, null):FlxSprite;
	
	public var score1(default, null):FlxText;
	public var score2(default, null):FlxText;

	public function new() {
		super();
		
		Game.level.addUI(this);
		createStuff();
		setupStuff();
		addStuff();
		moreSetup();
	}
	
	public function updateColors() {
		background1.color = Game.match.team1.color;
		background2.color = Game.match.team2.color;
	}
	
	public function updateScores() {
		score1.text = Std.string(Game.match.team1.score);
		score2.text = Std.string(Game.match.team2.score);
	}
	
	private function createStuff() {
		background1 = new FlxSprite();
		background2 = new FlxSprite();
		score1 = new FlxText(0, 0, 0, "00", 30);
		score2 = new FlxText(0, 0, 0, "00", 30);
	}
	
	private function setupStuff() {
		setupBackgrounds();
		setupTexts();
		updateTextPosition();
	}
	
	private function setupBackgrounds() {
		background1.alpha = background2.alpha = 0.75;
		background1.makeGraphic(cast score1.width * 1.5, cast score1.height * 1.5);
		background2.makeGraphic(cast score2.width * 1.5, cast score2.height * 1.5);
		background1.setTopLeft(background2.getBottomLeft());
	}
	
	private function setupTexts() {
		score1.fieldWidth = background1.width;
		score2.fieldWidth = background2.height;
		score1.alignment =
		score2.alignment = FlxTextAlign.CENTER;
		score1.graphic.persist =
		score2.graphic.persist = true;
	}
	
	private function updateTextPosition() {
		score1.setCenter(background1.getCenter());
		score2.setCenter(background2.getCenter());
	}
	
	private function addStuff() {
		add(background1);
		add(background2);
		add(score1);
		add(score2);
	}
	
	private function moreSetup() {
		setMidLeft(FlxPosition.screenMidLeft);
	}
	
}