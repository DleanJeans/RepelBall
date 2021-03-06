package objects;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import objects.Ball;
import systems.timers.SolidTimer;

class Powerup extends FlxSprite {
	public static inline var SVG_PATH = AssetPaths.Powerups__svg;
	
	public static inline var SPEED_BOOST = 0;
	public static inline var DOUBLE_BALLS = 1;
	public static inline var TRIPLE_BALLS = 2;
	public static inline var POWERUP_COUNT = 3;
	
	public var scaleTween:FlxTween;
	
	public var type(default, null):Int;
	public var activate(default, null):Ball->Void;
	public var deactivate(default, null):Ball->Void;
	
	private var _solidTimer(default, null):SolidTimer;
	private var _lifeTimer:FlxTimer;
	
	public function new(?type:Int) {
		super();
		_lifeTimer = new FlxTimer();
		_solidTimer = new SolidTimer(this);
		loadGraphic(Game.renderer.renderSvg(SVG_PATH), true, 48, 48);
	}
	
	public function startLifeTimer() {
		_lifeTimer.start(Settings.powerup.lifeTime, function(_) popOutThenKill());
	}
	
	public function setType(type:Int) {
		this.type = type;
		loadFrame(type);
		activate = Game.powerups.activations.list[type];
		deactivate = Game.powerups.deactivations.list[type];
	}
	
	private function loadFrame(frame:Int) {
		animation.frameIndex = frame;
	}
	
	public function popUp() {
		scale.set();
		var maxScale = Settings.powerup.hoveringScale.max;
		Game.tween.powerupScale(this, maxScale, maxScale, startHovering);
		_solidTimer.disableFor(Settings.powerup.popDuration / 10);
	}
	
	private function startHovering(tween:FlxTween) {
		Game.tween.powerupHovering(this);
	}
	
	public function popOutThenKill() {
		popOut(killAndRemove);
	}
	
	private function popOut(?onComplete:TweenCallback) {
		Game.tween.powerupScale(this, 0, 0, onComplete);
		solid = false;
	}
	
	private function killAndRemove(?tween:FlxTween) {
		kill();
		Game.stage.removePowerup(this);
	}
	
}