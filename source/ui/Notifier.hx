package ui;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Notifier {
	public var active:Bool = true;
	public var text(default, null):FlxText;
	public var fadeInOutTween(default, null):FlxTween;
	
	public function new() {
		text = new FlxText(0, 0, FlxG.width * 0.85, "", 30);
		text.alignment = FlxTextAlign.CENTER;
		text.screenCenter();
		text.y = FlxG.height * 0.75;
		Game.stage.addUI(text);
	}
	
	public function notify(text:String, ?effectFunction:Void->Void, color:FlxColor = Game.color.white) {
		if (!active) return;
		
		this.text.text = text;
		this.text.color = color;
		
		if (effectFunction == null)
			effectFunction = fadeOut.bind(0.5);
		
		effectFunction();
	}
	
	public function fadeOut(duration:Float = 0.5, ?onComplete:TweenCallback) {
		text.visible = true;
		text.alpha = 1;
		FlxSpriteUtil.fadeOut(text, duration, onComplete);
	}
	
	public function fadeInOut(duration:Float = 1) {
		text.visible = true;
		text.alpha = 0;
		
		if (fadeInOutTween != null && !fadeInOutTween.finished)
			fadeInOutTween.cancel();
		fadeInOutTween = FlxTween.tween(text, { alpha: 1 }, duration, { type:FlxTween.PINGPONG });
	}
	
	public function stopFadingInOut() {
		fadeInOutTween.cancel();
		text.visible = false;
	}
	
	public inline function show() {
		text.visible = true;
		text.alpha = 1;
	}
	
	public inline function hide() {
		text.visible = false;
		text.alpha = 0;
	}
	
	public function toggleActivation() {
		if (active) {
			notify("Notifier: " + Game.messages.onOff(false));
			active = false;
		}
		else {
			active = true;
			notify("Notifier: " + Game.messages.onOff(true));
		}
	}
	
}