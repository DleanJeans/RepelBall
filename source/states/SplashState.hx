package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxSignal;
import flixel.util.FlxTimer;
import openfl.filters.BlurFilter;
import flixel.graphics.frames.FlxFilterFrames;
using flixel.util.FlxSpriteUtil;

class SplashState extends FlxSubState {
	public static inline var MIN_BLUR = 15;
	public static inline var MAX_BLUR = 30;
	
	public static inline var MIN_OFFSET_Y = -5;
	public static inline var MAX_OFFSET_Y = 5;
	
	public var logo(default, null):FlxSprite;
	public var shadow(default, null):FlxSprite;
	public var done(default, null):FlxSignal;
	
	private var blurFilter:BlurFilter;
	private var filterFrames:FlxFilterFrames;
	private var tween:FlxTween;

	override public function create():Void{
		bgColor = Game.color.white;
		
		logo = new FlxSprite(0, 0, Game.renderer.renderSvg(AssetPaths.RepelliumGames__svg));
		logo.setGraphicSize(cast FlxG.width * 0.8);
		logo.updateHitbox();
		logo.screenCenter();
		add(logo);
		
		var sprite = new FlxSprite();
		sprite.makeGraphic(cast logo.width, 10, 0x0);
		sprite.drawEllipse(0, 0, sprite.width, sprite.height, Game.color.black);
		
		shadow = new FlxSprite(logo.x, logo.getBottom() + 20);
		shadow.loadGraphicFromSprite(sprite);
		add(shadow);
		
		blurFilter = new BlurFilter(MIN_BLUR, MIN_BLUR);
		filterFrames = FlxFilterFrames.fromFrames(shadow.frames, 50, 100, [blurFilter]);
		
		logo.offset.y = MIN_OFFSET_Y;
		tween = FlxTween.tween(logo.offset, { y: MAX_OFFSET_Y }, 1, { 
			type: FlxTween.PINGPONG,
			ease: FlxEase.sineInOut,
			onUpdate:function(_) blurFilter.blurX = blurFilter.blurY = FlxMath.lerp(MIN_BLUR, MAX_BLUR, tween.backward ? 1 - tween.percent : tween.percent)
		});
		
		done = new FlxSignal();
		
		new FlxTimer().start(3, fadeToMenu);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		applyFilter();
	}
	
	private function applyFilter() {
		filterFrames.applyToSprite(shadow, false, true);
	}

	private function fadeToMenu(timer:FlxTimer)
	{
		camera.fade(Game.color.background, 0.5, false, 
		function() Game.states.menu());
	}

}