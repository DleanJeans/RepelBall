package objects;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import objects.Ball;

class Powerup extends FlxSprite {
	public static inline var SVG_PATH = AssetPaths.Powerups__svg;
	
	public static inline var DOUBLE_BALLS = 0;
	public static inline var TRIPLE_BALLS = 1;
	
	public var activate(default, null):Ball->Void;
	
	private var _lifeTimer:FlxTimer;
	
	public function new(?type:Int) {
		super();
		solid = false;
		_lifeTimer = new FlxTimer();
		setType(type);
	}
	
	public function startLifeTimer() {
		_lifeTimer.start(Game.settings.POWERUP_LIFETIME, dieOut);
	}
	
	private function dieOut(timer:FlxTimer) {
		popOutThenKill();
	}
	
	public function setType(?type:Int) {
		if (type == null) return;
		loadFrame(type);
		activate = Game.powerups.effects.powerups[type];
	}
	
	private function loadFrame(frame:Int) {
		loadGraphic(Game.renderer.getSvg(SVG_PATH), true, 48, 48);
		animation.frameIndex = frame;
	}
	
	public function popUp() {
		scale.set();
		Game.tween.powerupScale(this, 1, 1, enableSolid);
	}
	
	private inline function enableSolid(?tween:FlxTween) {
		solid = true;
	}
	
	public function popOutThenKill() {
		popOut(killAndRemoveSelf);
	}
	
	private function popOut(?onComplete:TweenCallback) {
		Game.tween.powerupScale(this, 0, 0, onComplete);
		solid = false;
	}
	
	private function killAndRemoveSelf(?tween:FlxTween) {
		kill();
		Game.level.removePowerup(this);
	}
	
}