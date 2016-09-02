package systems;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets;

class Settings {
	public var BALL_STARTING_SPEED = 200;
	public var maxBalls(default, null):Array<Int> = [for (i in 1...9) i];
	public var scoresToWin(default, null):Array<Int> = [3, 5, 10];
	public var scoreToWinStrings(default, null):Array<String> = ["Casual 3", "Standard 5", "Extended 10"];
	
	public function new() {
		addTestScoreSettingsOnDebug();
		setSeparateBias();
		setDefaultFont();
		disableFlixelMouseOnJs();
	}
	
	private function addTestScoreSettingsOnDebug() {
		#if debug
		scoresToWin.unshift(1);
		scoreToWinStrings.unshift("Test 1");
		#end
	}
	
	private inline function setSeparateBias() {
		FlxObject.SEPARATE_BIAS = Game.unitLength();
	}
	
	private inline function setDefaultFont() {
		FlxAssets.FONT_DEFAULT = AssetPaths.SquareFont__ttf;
	}
	
	private inline function disableFlixelMouseOnJs() {
		#if js
		FlxG.mouse.useSystemCursor = true;
		if (FlxG.html5.onMobile)
			FlxG.mouse.visible = false;
		#end
	}
	
}