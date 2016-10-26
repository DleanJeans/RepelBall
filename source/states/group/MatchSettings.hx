package states.group;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxAxes;
import flixel.util.FlxSignal;
import ui.LoopSelector;
import ui.SideButton;
import states.group.TeamSettings;

class MatchSettings extends FlxSpriteGroup {
	public var newMatchHeader(default, null):SideButton;
	public var backButton(default, null):SideButton;
	public var startButton(default, null):SideButton;
	
	public var maxBallsLoop(default, null):LoopSelector;
	public var scoresLoop(default, null):LoopSelector;
	
	public var teamSettingsGroup(default, null):FlxSpriteGroup;
	public var teamSettings1(default, null):TeamSettings;
	public var teamSettings2(default, null):TeamSettings;
	
	public var back(default, null):FlxSignal;
	public var start(default, null):FlxSignal;

	public function new() {
		super();
		
		createStuff();
		setupStuff();
		addStuff();
		
		start.addOnce(saveSettings);
	}
	
	public function saveSettings() {
		Game.save.saveMatchSettings(maxBallsLoop.getIndex(), scoresLoop.getIndex(),
		teamSettings1.colorSwatch.index, teamSettings2.colorSwatch.index);
	}
	
	public inline function sameTeamColor() {
		return teamSettings1.teamColor == teamSettings2.teamColor;
	}
	
	public function apply() {
		Game.match.scoreToWin = cast scoresLoop.getCurrentValue();
		Game.match.maxBalls = cast maxBallsLoop.getCurrentValue();
		teamSettings1.apply(Game.match.team1);
		teamSettings2.apply(Game.match.team2);
	}
	
	private function createStuff() {
		back = new FlxSignal();
		start = new FlxSignal();
		
		newMatchHeader = new SideButton(0, 50, cast FlxG.width / 2, 50, "New Match", 40);
		backButton = new SideButton(0, FlxG.height - 100, 240, 50, "Back", 35, back.dispatch);
		startButton = new SideButton(0, FlxG.height - 100, 240, 50, "Start", 35, start.dispatch);
		
		maxBallsLoop = Game.pools.getLoopSelector("Max Balls", Settings.maxBalls);
		scoresLoop = Game.pools.getLoopSelector("Scores", Settings.scoresToWin);
		
		teamSettingsGroup = new FlxSpriteGroup();
		teamSettings1 = new TeamSettings(0, 300);
		teamSettings2 = new TeamSettings(0, 300);
	}
	
	private function setupStuff() {
		startButton.flip();
		startButton.setRight(FlxG.width);
		
		maxBallsLoop.y = newMatchHeader.getBottom() + 50;
		maxBallsLoop.screenCenter(FlxAxes.X);
		scoresLoop.screenCenter(FlxAxes.X);
		scoresLoop.y = maxBallsLoop.getBottom() + Settings.LOOP_SELECTOR_SPACE_Y;
		
		teamSettingsGroup.add(teamSettings1);
		teamSettingsGroup.add(teamSettings2);
		teamSettings2.x = teamSettings1.getRight() + Settings.TEAM_SETTINGS_SPACE_X;
		teamSettingsGroup.screenCenter(FlxAxes.X);
		
		maxBallsLoop.select(Game.save.maxBallsIndex);
		scoresLoop.select(Game.save.scoresIndex);
		
		selectRandomColorOnSwatches();
	}
	
	private inline function selectRandomColorOnSwatches() {
		var maxIndex = Game.color.list.length - 1;
		
		if (Game.save.colorsNotSet()) {
			Game.save.color1Index = teamSettings1.colorSwatch.selectRandom();
			Game.save.color2Index = teamSettings2.colorSwatch.selectRandom(Game.save.color1Index);
		}
		else {
			teamSettings1.colorSwatch.selectByIndex(Game.save.color1Index);
			teamSettings2.colorSwatch.selectByIndex(Game.save.color2Index);
		}
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