package systems;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets;
import flixel.text.FlxText;

class Settings {
	public var COLOR_SWATCH_LABEL_SIZE:Int;
	public var COLOR_SWATCH_SELECTOR_WIDTH:Int;
	public var COLOR_SWATCH_SIZE:Int;
	
	public var LOOP_SELECTOR_TEXT_SIZE:Int;
	public var LOOP_SELECTOR_HEIGHT:Int;
	public var LOOP_SELECTOR_SPACE_Y:Int;
	
	public var TEAM_SETTINGS_TEAM_NAME_SIZE:Int;
	public var TEAM_SETTINGS_PADDLE_BACK_SIZE:Int;
	public var TEAM_SETTINGS_SPACE_X:Int;
	
	public var MULTI_GOAL_THRESHOLD:Int = 1;
	public var BALL_STARTING_SPEED:Int = cast FlxG.height / 4;
	public var COLOR_CHANGING_TWEEN_DURATION = 0.5;
	public var MESSAGES_FIELD_WIDTH = FlxG.width * 0.85;
	public var SLOW_MO_TIME_SCALE = 0.2;
	public var BALL_FX_DURATION = 0.1;
	public var TRAIL_NODE_LIMIT = 25;
	
	/**
	 * Mouth will frown when ball is outside of this distance
	 */
	public var EXPRESSION_FROWN_BALL_OUT_REACH = 25;
	/**
	 * Eyes will look at the nearest ball in this radius
	 */
	public var EXPRESSION_BALL_DETECTION_RADIUS = FlxG.height / 3;
	
	public var MIN_HOVERING_DURATION = 0.4;
	public var MAX_HOVERING_DURATION = 0.6;
	public var MAX_HOVERING_DELAY = 0.25;
	public var KNOCK_BACK_DURATION = 0.5;
	
	public var maxBalls(default, null):Array<Int> = [for (i in 1...5) i];
	public var scoresToWin(default, null):Array<Int> = [3, 5, 10];
	
	public function new() {
		FlxG.camera.antialiasing = true;
		setupUISettings();
		addTestScoreSettingsOnDebug();
		setSeparateBias();
		setDefaultFont();
		disableFlixelMouseOnJs();
	}
	
	private function setupUISettings() {
		#if mobile
		
		COLOR_SWATCH_LABEL_SIZE = 30;
		COLOR_SWATCH_SELECTOR_WIDTH = 6;
		COLOR_SWATCH_SIZE = 50;
		
		TEAM_SETTINGS_TEAM_NAME_SIZE = 40;
		TEAM_SETTINGS_PADDLE_BACK_SIZE = 150;
		TEAM_SETTINGS_SPACE_X = -20;
		
		LOOP_SELECTOR_HEIGHT = 60;
		LOOP_SELECTOR_TEXT_SIZE = 35;
		LOOP_SELECTOR_SPACE_Y = 0;
		
		#else
		
		COLOR_SWATCH_LABEL_SIZE = 20;
		COLOR_SWATCH_SELECTOR_WIDTH = 6;
		COLOR_SWATCH_SIZE = 30;
		
		TEAM_SETTINGS_TEAM_NAME_SIZE = 30;
		TEAM_SETTINGS_PADDLE_BACK_SIZE = 150;
		TEAM_SETTINGS_SPACE_X = 20;
		
		LOOP_SELECTOR_HEIGHT = 30;
		LOOP_SELECTOR_TEXT_SIZE = 25;
		LOOP_SELECTOR_SPACE_Y = 20;
		
		#end
	}
	
	private function addTestScoreSettingsOnDebug() {
		#if debug
		scoresToWin.unshift(1);
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