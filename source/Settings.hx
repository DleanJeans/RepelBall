package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets;
import flixel.text.FlxText;

class Settings {
	public static var COLOR_SWATCH_LABEL_SIZE:Int;
	public static var COLOR_SWATCH_SELECTOR_WIDTH:Int;
	public static var COLOR_SWATCH_SIZE:Int;
	
	public static var LOOP_SELECTOR_TEXT_SIZE:Int;
	public static var LOOP_SELECTOR_HEIGHT:Int;
	public static var LOOP_SELECTOR_SPACE_Y:Int;
	
	public static var TEAM_SETTINGS_TEAM_NAME_SIZE:Int;
	public static var TEAM_SETTINGS_PADDLE_BACK_SIZE:Int;
	public static var TEAM_SETTINGS_SPACE_X:Int;
	
	public static var MESSAGES_FIELD_WIDTH:Float;
	
	public static var BALL_STARTING_SPEED:Int;
	public static var BALL_FX_DURATION = 0.1;
	
	public static var PRE_ROUND_COUNTDOWN:Int = 3;
	public static var MULTI_GOAL_THRESHOLD:Int = 1;
	
	public static var COLOR_CHANGING_TWEEN_DURATION = 0.5;
	
	public static var SLOW_MO_TIME_SCALE = 0.2;
	
	public static var TRAIL_NODE_LIMIT = 25;
	public static var TRAIL_COOLDOWN = 0.02 ;
	
	public static var SCREEN_SHAKE_DURATION = 0.1;
	public static var GLITCH_DURATION = 0.05;
	
	public static var POWERUP_POPPING_DURATION = 0.5;
	public static var POWERUP_LIFETIME = 3;
	
	public static var POWERUP_AREA_WIDTH:Int;
	public static var POWERUP_AREA_HEIGHT:Int;
	public static var POWERUP_MIN_X:Int;
	public static var POWERUP_MAX_X:Int;
	public static var POWERUP_MIN_Y:Int;
	public static var POWERUP_MAX_Y:Int;
	
	/**
	 * Mouth will frown when ball is outside of this distance
	 */
	public static var EXPRESSION_FROWN_BALL_OUT_REACH = 25;
	/**
	 * Eyes will look at the nearest ball in this radius
	 */
	public static var EXPRESSION_BALL_DETECTION_RADIUS:Float;
	
	public static var MIN_HOVERING_DURATION = 0.4;
	public static var MAX_HOVERING_DURATION = 0.6;
	public static var MAX_HOVERING_DELAY = 0.25;
	public static var KNOCK_BACK_DURATION = 0.5;
	
	public static var MIN_POWERUP_HOVERING_SCALE = 0.85;
	public static var MAX_POWERUP_HOVERING_SCALE = 1.15;
	
	public static var maxBalls(default, null):Array<Int> = [for (i in 1...5) i];
	public static var scoresToWin(default, null):Array<Int> = [3, 5, 10];
	
	public static function apply() {
		FlxG.camera.antialiasing = true;
		setupValuesRegardingScreenSize();
		setupPreRoundCountdown();
		setupUISettings();
		addTestScoreSettingsOnDebug();
		setSeparateBias();
		setDefaultFont();
		disableFlixelMouseOnJs();
	}
	
	private static function setupValuesRegardingScreenSize() {
		BALL_STARTING_SPEED = cast FlxG.height / 4;
		MESSAGES_FIELD_WIDTH = FlxG.width * 0.85;
		EXPRESSION_BALL_DETECTION_RADIUS = FlxG.height / 3;
		
		POWERUP_AREA_WIDTH = cast FlxG.width * 0.8;
		POWERUP_AREA_HEIGHT = cast FlxG.height * 0.5;
		POWERUP_MIN_X = cast (FlxG.width - POWERUP_AREA_WIDTH) / 2;
		POWERUP_MAX_X = cast POWERUP_MIN_X + POWERUP_AREA_WIDTH;
		POWERUP_MIN_Y = cast (FlxG.height - POWERUP_AREA_HEIGHT) / 2;
		POWERUP_MAX_Y = cast POWERUP_MIN_Y + POWERUP_AREA_HEIGHT;
	}
	
	private static function setupPreRoundCountdown() {
		#if testing
		PRE_ROUND_COUNTDOWN = 1;
		#end
	}
	
	/**
	 * Setup bigger Match Settings for mobile targets
	 */
	private static function setupUISettings() {
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
	
	private static function addTestScoreSettingsOnDebug() {
		#if debug
		scoresToWin.unshift(1);
		#end
	}
	
	private static inline function setSeparateBias() {
		FlxObject.SEPARATE_BIAS = Game.unitLength();
	}
	
	private static inline function setDefaultFont() {
		FlxAssets.FONT_DEFAULT = AssetPaths.SquareFont__ttf;
	}
	
	private static inline function disableFlixelMouseOnJs() {
		#if js
		FlxG.mouse.useSystemCursor = true;
		if (FlxG.html5.onMobile)
			FlxG.mouse.visible = false;
		#end
	}
	
	public static inline function alignCenter(text:FlxText) {
		text.alignment = FlxTextAlign.CENTER;
	}
	
}