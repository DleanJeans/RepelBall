package states.group;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSignal;
import ui.LoopSelector;
import ui.SideButton;
import ui.TeamSettings;
using flixel.addons.util.position.FlxPosition;

class MatchSettings extends FlxSpriteGroup {
	public var newMatchHeader(default, null):SideButton;
	public var backButton(default, null):SideButton;
	public var startButton(default, null):SideButton;
	
	public var maxBallsLoop(default, null):LoopSelector;
	public var scoresLoop(default, null):LoopSelector;
	
	public var teamSettings1(default, null):TeamSettings;
	public var teamSettings2(default, null):TeamSettings;
	
	public var back(default, null):FlxSignal;
	public var start(default, null):FlxSignal;

	public function new() {
		super();
		
		createStuff();
		setupStuff();
		addStuff();
	}
	
	public inline function sameTeamColor() {
		return teamSettings1.teamColor == teamSettings2.teamColor;
	}
	
	public function apply() {
		Game.match.scoreToWin = Game.settings.scoresToWin[scoresLoop.getIndex()];
		Game.match.maxBalls = cast maxBallsLoop.getCurrentValue();
		teamSettings1.apply(Game.match.team1);
		teamSettings2.apply(Game.match.team2);
	}
	
	private function createStuff() {
		back = new FlxSignal();
		start = new FlxSignal();
		
		newMatchHeader = new SideButton(0, 50, cast FlxG.width / 2, 50, "New Match", 40);
		backButton = new SideButton(0, FlxG.height - 75, 240, 50, "Back", 35, back.dispatch);
		startButton = new SideButton(0, FlxG.height - 75, 240, 50, "Start", 35, start.dispatch);
		
		maxBallsLoop = new LoopSelector(50, 125, 300, 30, "Max Balls", Game.settings.maxBalls, 175);
		scoresLoop = new LoopSelector(50, 175, 300, 30, "Scores", Game.settings.scoreToWinStrings, 175);
		
		teamSettings1 = new TeamSettings(50, 300);
		teamSettings2 = new TeamSettings(325, 300);
	}
	
	private function setupStuff() {
		startButton.flip();
		startButton.setRight(FlxG.width);
		
		maxBallsLoop.select(2);
	}
	
	private function addStuff() {
		add(newMatchHeader);
		add(backButton);
		add(startButton);
		add(maxBallsLoop);
		add(scoresLoop);
		add(teamSettings1);
		add(teamSettings2);
	}
	
}