package objects.personality;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import format.SVG;
import objects.Paddle;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Graphics;
import openfl.display.Sprite;

@:enum
abstract MouthFrame(Int) {
	var SMILE = 0;
	var FROWN = 1;
	var OOH = 2;
}

enum MouthExpression {
	SMILING;
	FROWNING;
	OOH;
	CLOSED;
}

class Mouth extends FlxSprite {
	public static inline var SVG_PATH = AssetPaths.Mouths__svg;
	
	public var tween(default, null):FlxTween;
	public var paddle:Paddle;
	
	private var _currentExpression:MouthExpression;
	private var _scale:FlxPoint;
	
	public function new() {
		super(0, 0);
		_scale = FlxPoint.get(1, 1);
		loadGraphic(Game.renderer.renderSvg(SVG_PATH), true, 24, 12);
		solid = false;
		ignoreDrawDebug = true;
		smile();
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		updateOffset();
		multiplyScale();
	}
	
	private inline function multiplyScale() {
		scale.x *= _scale.x;
		scale.y *= _scale.y;
	}
	
	private inline function updateOffset() {
		offset.copyFrom(paddle.offset);
	}
	
	public function attachToPaddle(paddle:Paddle) {
		this.paddle = paddle;
		setMidBottom(paddle.getMidBottom());
		y -= 3;
	}
	
	public function changeFrame(expression:MouthFrame) {
		animation.frameIndex = cast expression;
	}
	
	public function smile() {
		if (_currentExpression == SMILING) return;
		
		stopTween();
		changeFrame(SMILE);
		tweenScale(null, 1);
		_currentExpression = SMILING;
	}
	
	public function close() {
		if (_currentExpression == CLOSED) return;
		_currentExpression = CLOSED;
		stopTween();
		changeFrame(SMILE);
		
		tweenScale(1, 0.1);
	}
	
	public function frown() {
		if (_currentExpression == FROWNING) return;
		_currentExpression = FROWNING;
		stopTween();
		changeFrame(FROWN);
		tweenScale(null, -1);
	}
	
	public function ooh() {
		if (_currentExpression == OOH) return;
		_currentExpression = OOH;
		stopTween();
		changeFrame(OOH);
		scale.set(0.5, 0.5);
	}
	
	private inline function tweenScale(?x:Float, ?y:Float) {
		if (x == null && y == null) return;
		var values:Dynamic = {};
		if (x != null)
			values.x = x;
		if (y != null)
			values.y = y;
		tween = FlxTween.tween(_scale, values, 0.25);
	}
	
	private inline function stopTween() {
		if (tween != null)
			tween.cancel();
	}
	
}