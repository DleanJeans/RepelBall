package;

import flixel.util.helpers.FlxBounds;
import openfl.display.StageQuality;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxRect;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.helpers.FlxRange;

class Settings {
	private static inline var UNIT_LENGTH = 24;
	public static inline function unitLength(times:Float = 1):Int {
		return cast UNIT_LENGTH * times;
	}
	
	public static var duration:Duration = {};
	public static var timeScale:TimeScale = {};
	public static var trail:Trail = {};
	public static var ball:Ball = {};
	public static var powerup:Powerup = {};
	public static var paddle:Paddle = {};
	public static var expression:Expression = {};
	
	public static var maxBalls(default, null):Array<Int> = [for (i in 1...5) i];
	public static var scoresToWin(default, null):Array<Int> = [3, 5, 10];
	
	public static function apply() {
		init();
		
		enableAntialiasing();
		setupPreRoundCountdown();
		addTestScoreSettingsOnDebug();
		setSeparateBias();
		setDefaultFont();
		disableFlixelMouseOnJs();
	}
	
	private static function init() {
		duration.multiGoalThresholdTime = 1;
		duration.preRoundCountdown = 3;
		duration.glitch = 0.1;
		duration.screenShake = 0.05;
		duration.pause = 0.03;
		duration.paddleColorTween = 0.5;
		duration.hovering = new FlxBounds(0.4, 0.6);
		
		timeScale.pause = 0.1;
		timeScale.slowMo = 0.1;
		
		trail.cooldown = 0.02;
		trail.nodeLimit = 25;
		
		ball.fxDuration = 0.1;
		
		powerup.area = FlxRect.get(FlxG.width * 0.1, FlxG.height * 0.25, FlxG.width * 0.8, FlxG.height * 0.5);
		powerup.popDuration = 0.5;
		powerup.lifeTime = 10;
		powerup.hoveringScale = new FlxBounds(0.85, 1.15);
		
		paddle.maxHoveringDelay = 0.25;
		paddle.knockBackDuration = 0.5;
		
		expression.frownBallOutOfReach = 25;
		expression.ballDetectionRadius = FlxG.width / 2;
	}
	
	private static function enableAntialiasing() {
		FlxG.camera.antialiasing = true;
		FlxG.stage.quality = StageQuality.HIGH;
	}
	
	private static function setupPreRoundCountdown() {
		#if testing
		Settings.duration.preRoundCountdown = 1;
		#end
	}
	
	private static function addTestScoreSettingsOnDebug() {
		#if debug
		scoresToWin.unshift(1);
		#end
	}
	
	private static inline function setSeparateBias() {
		FlxObject.SEPARATE_BIAS = Settings.unitLength();
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

typedef Duration = {
	?hovering:FlxBounds<Float>,
	?preRoundCountdown:Int,
	?multiGoalThresholdTime:Float,
	?pause:Float,
	?screenShake:Float,
	?glitch:Float,
	?paddleColorTween:Float,
}

typedef TimeScale = {
	?slowMo:Float,
	?pause:Float,
}

typedef Trail = {
	?nodeLimit:Int,
	?cooldown:Float,
}

typedef Ball = {
	?fxDuration:Float,
}

typedef Powerup = {
	?area:FlxRect,
	?popDuration:Float,
	?lifeTime:Float,
	?hoveringScale:FlxBounds<Float>,
}

typedef Paddle = {
	?maxHoveringDelay:Float,
	?knockBackDuration:Float,
}

typedef Expression = {
	?frownBallOutOfReach:Int,
	?ballDetectionRadius:Float,
}