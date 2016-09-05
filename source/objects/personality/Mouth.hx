package objects.personality;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import objects.Paddle;
using flixel.addons.util.position.FlxPosition;

@:enum
abstract MouthFrame(Int) {
	var SMILE = 0;
	var FROWN = 1;
	var OOH = 2;
}

enum MouthExpression {
	SMILING;
	FROWNING;
	OOH_ING;
	SHUTTING;
}

class Mouth extends FlxSprite {
	public var tween(default, null):FlxTween;
	public var paddle:Paddle;
	
	private var _currentExpression:MouthExpression;
	
	public function new() {
		super(0, 0);
		loadGraphic(AssetPaths.Mouths__png, true, 24, 12);
		solid = false;
		smile();
	}
	
	public function attachToPaddle(paddle:Paddle) {
		this.paddle = paddle;
		setMidBottom(paddle.getMidBottom());
		y -= 3;
	}
	
	override public function update(elapsed:Float):Void {
		offset.copyFrom(paddle.offset);
		super.update(elapsed);
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
	
	public function shut() {
		if (_currentExpression == SHUTTING) return;
		_currentExpression = SHUTTING;
		stopTween();
		changeFrame(SMILE);
		
		tweenScale(null, 0.1);
	}
	
	public function frown() {
		if (_currentExpression == FROWNING) return;
		_currentExpression = FROWNING;
		stopTween();
		changeFrame(FROWN);
		tweenScale(null, -1);
	}
	
	public function ooh() {
		if (_currentExpression == OOH_ING) return;
		_currentExpression = OOH_ING;
		stopTween();
		changeFrame(OOH);
		scale.set(1, 1);
		tweenScale(0.2, 0.2);
	}
	
	private inline function tweenScale(?x:Float, ?y:Float) {
		if (x == null && y == null) return;
		var values:Dynamic = {};
		if (x != null)
			values.x = x;
		if (y != null)
			values.y = y;
		tween = FlxTween.tween(this.scale, values, 0.25);
	}
	
	private inline function stopTween() {
		if (tween != null)
			tween.cancel();
	}
	
}