package states.group;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import objects.Paddle;
import objects.PaddleWrapper;
import objects.personality.EyePair;
import systems.match.Team;
import ui.ColorSwatchSelector;
using flixel.addons.util.position.FlxPosition;

class TeamSettings extends FlxSpriteGroup {
	public var teamName(default, null):FlxText;
	public var colorSwatch(default, null):ColorSwatchSelector;
	public var paddleBack(default, null):FlxSprite;
	public var paddleWrapper(default, null):PaddleWrapper;
	public var paddle(get, null):Paddle;
	public var teamColor(get, never):FlxColor;
	
	public function new(x:Float = 0, y:Float = 0) {
		super();
		
		createStuff();
		setupStuff();
		addStuff();
		moreSetup(x, y);
	}
	
	override public function destroy():Void {
		remove(paddleWrapper);
		super.destroy();
	}
	
	public function apply(team:Team) {
		team.setup(teamName.text, teamColor);
		team.addPaddle(paddleWrapper);
		resetPaddleToNormal();
	}
	
	private function resetPaddleToNormal() {
		Game.paddle.hoverer.stopHovering(paddle);
		paddleWrapper.face.eyes.targetting = BALL;
	}
	
	private function updateTeamName(colorSwatch:ColorSwatchSelector) {
		teamName.text = "Team " + colorSwatch.getColorName();
		teamName.color = colorSwatch.getColor();
		paddleWrapper.color = colorSwatch.getColor();
	}
	
	private function createStuff() {
		teamName = new FlxText();
		colorSwatch = Game.pools.getDefaultColorSwatch();
		paddleBack = new FlxSprite();
		paddleWrapper = Game.pools.getPaddle();
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
		
		paddleWrapper.setCenter(paddleBack.getCenter());
		paddleWrapper.face.eyes.targetting = POINTER;
	}
	
	private function addStuff() {
		add(teamName);
		add(colorSwatch);
		add(paddleBack);
		add(paddleWrapper);
	}
	
	private function moreSetup(x:Float, y:Float) {
		setPosition(x, y);
		updateTeamName(colorSwatch);
		colorSwatch.fixSelector();
		Game.paddle.hoverer.startHovering(paddle, Game.unitLength(0.75));
	}
	
	inline function get_teamColor():FlxColor {
		return teamName.color;
	}
	
	function get_paddle():Paddle {
		return paddleWrapper.paddle;
	}
	
}