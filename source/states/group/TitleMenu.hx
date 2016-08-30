package states.group;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxSignal;
import systems.ui.SideButton;
using flixel.addons.util.position.FlxPosition;

class TitleMenu extends FlxSpriteGroup {
	public var titleText(default, null):FlxText;
	public var newMatchButton(default, null):SideButton;
	public var optionsButton(default, null):SideButton;
	public var creditsButton(default, null):SideButton;
	
	public var newMatch(default, null):FlxSignal;
	public var options(default, null):FlxSignal;
	public var credits(default, null):FlxSignal;
	
	public function new() {
		super();
		
		createStuff();
		setupStuff();
		addStuff();
	}
	
	private function createStuff() {
		newMatch = new FlxSignal();
		options = new FlxSignal();
		credits = new FlxSignal();		
		
		titleText = new FlxText(0, 50, 0, "RepelBall", 75);
		newMatchButton = new SideButton(0, titleText.getBottom() + 150, cast FlxG.width / 2, 50, "New Match", 40, newMatch.dispatch);
		optionsButton = new SideButton(0, newMatchButton.getBottom() + 50, cast FlxG.width / 2, 50, "Options", 40, options.dispatch);
		creditsButton = new SideButton(0, optionsButton.getBottom() + 50, cast FlxG.width / 2, 50, "Credits", 40, credits.dispatch);
	}
	
	private function setupStuff() {
		titleText.screenCenter(FlxAxes.X);
	}
	
	private function addStuff() {
		add(titleText);
		add(newMatchButton);
		add(optionsButton);
		add(creditsButton);
	}
	
}