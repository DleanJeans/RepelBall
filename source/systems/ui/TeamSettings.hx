package systems.ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import objects.Paddle;
using flixel.addons.util.position.FlxPosition;

class TeamSettings extends FlxSpriteGroup {
	public var teamName:FlxText;
	public var colorSwatch:ColorSwatchSelector;
	public var paddleBack:FlxSprite;
	public var paddle:Paddle;
	
	public var controlSettingsButton:FlxButton;
	
	public function new(x:Float = 0, y:Float = 0) {
		super();
		
		createStuff();
		setupStuff();
		addStuff();
		moreSetup(x, y);
	}
	
	private function updateTeamName(colorSwatch:ColorSwatchSelector) {
		teamName.text = "Team " + colorSwatch.getColorName();
		teamName.color = colorSwatch.getColor();
		paddle.color = colorSwatch.getColor();
	}
	
	private function createStuff() {
		teamName = new FlxText();
		colorSwatch = Game.pools.getDefaultColorSwatch();
		paddleBack = new FlxSprite();
		paddle = Game.pools.getPaddle();
		//controlSettingsButton = new FlxButton();
	}
	
	private function setupStuff() {
		teamName.size = 30;
		teamName.fieldWidth = colorSwatch.width * 1.75;
		teamName.alignment = FlxTextAlign.CENTER;
		
		colorSwatch.colorChangedCallback = updateTeamName;
		colorSwatch.setMidTop(teamName.getMidBottom());
		colorSwatch.y += 20;
		
		paddleBack.makeGraphic(150, 150);
		paddleBack.alpha = 0.25;
		paddleBack.setMidTop(colorSwatch.getMidBottom());
		paddleBack.y += 30;
		
		paddle.scale.set(1.5, 1.5);
		paddle.updateHitbox();
		paddle.setCenter(paddleBack.getCenter());
	}
	
	private function addStuff() {
		add(teamName);
		add(colorSwatch);
		add(paddleBack);
		add(paddle);
	}
	
	private function moreSetup(x:Float, y:Float) {
		setPosition(x, y);
		updateTeamName(colorSwatch);
		colorSwatch.fixSelector();
	}
	
}