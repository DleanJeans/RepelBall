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
	
	public var PRE_ROUND_COUNTDOWN:Int = 3;
	public var MULTI_GOAL_THRESHOLD:Int = 1;
	public var BALL_STARTING_SPEED:Int = cast FlxG.height / 4;
	public var COLOR_CHANGING_TWEEN_DURATION = 0.5;
	public var MESSAGES_FIELD_WIDTH = FlxG.width * 0.85;
	public var SLOW_MO_TIME_SCALE = 0.2;
	public var BALL_FX_DURATION = 0.1;
	public var TRAIL_NODE_LIMIT = 25;
	public var TRAIL_COOLDOWN = 0.02 ;
	public var SCREEN_SHAKE_DURATION = 0.1;
	public var GLITCH_DURATION = 0.05;
	public var POWERUP_POPPING_DURATION = 0.5;
	
	public var POWERUP_AREA_WIDTH:Int = cast FlxG.width * 0.8;
	public var POWERUP_AREA_HEIGHT:Int = cast FlxG.height * 0.5;
	public var POWERUP_MIN_X:Int;
	public var POWERUP_MAX_X:Int;
	public var POWERUP_MIN_Y:Int;
	public var POWERUP_MAX_Y:Int;
	
	public var POWERUP_LIFETIME = 6;
	
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
	
	public var MIN_POWERUP_HOVERING_SCALE = 0.85;
	public var MAX_POWERUP_HOVERING_SCALE = 1.15;
	
	public var maxBalls(default, null):Array<Int> = [for (i in 1...5) i];
	public var scoresToWin(default, null):Array<Int> = [3, 5, 10];
	
	public function new() {
		FlxG.camera.antialiasing = true;
		setupPreRoundCountdown();
		setupPowerupArea();
		setupUISettings();
		addTestScoreSettingsOnDebug();
		setSeparateBias();
		setDefaultFont();
		disableFlixelMouseOnJs();
	}
	
	private function setupPreRoundCountdown() {
		#if testing
		PRE_ROUND_COUNTDOWN = 1;
		#end
	}
	
	private function setupPowerupArea() {
		POWERUP_MIN_X = cast (FlxG.width - POWERUP_AREA_WIDTH) / 2;
		POWERUP_MAX_X = cast POWERUP_MIN_X + POWERUP_AREA_WIDTH;
		POWERUP_MIN_Y = cast (FlxG.height - POWERUP_AREA_HEIGHT) / 2;
		POWERUP_MAX_Y = cast POWERUP_MIN_Y + POWERUP_AREA_HEIGHT;
	}
	
	/**
	 * Setup bigger Match Settings for mobile targets
	 */
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