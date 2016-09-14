package systems;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets;
import flixel.text.FlxText;

class Settings {
	public var MULTI_GOAL_THRESHOLD:Int = 1;
	public var BALL_STARTING_SPEED:Int = cast FlxG.height / 4;
	public var COLOR_CHANGED_TWEEN_DURATION = 0.5;
	public var MESSAGES_FIELD_WIDTH = FlxG.width * 0.85;
	
	public var maxBalls(default, null):Array<Int> = [for (i in 1...5) i];
	public var scoresToWin(default, null):Array<Int> = [3, 5, 10];
	public var scoreToWinStrings(default, null):Array<String> = ["Casual 3", "Standard 5", "Extended 10"];
	
	public function new() {
		FlxG.camera.antialiasing = true;
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
	
	public inline function alignCenter(text:FlxText) {
		text.alignment = FlxTextAlign.CENTER;
	}
	
}