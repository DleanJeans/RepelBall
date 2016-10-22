package systems.screen;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import objects.Ball;
import objects.Wall;

class ScreenShake {
	public var power:Float = 0.025;
	
	private var _tween:FlxTween;
	
	public function new() {}
	
	public function ball(ball:Ball, object:FlxObject) {
		shake(ball.velocity.x * power, -ball.velocity.y * power);
	}
	
	public function shake(powerX:Float, powerY:Float) {
		if (_tween != null && !_tween.finished)
			_tween.cancel();
		_tween = tweenCameraScroll(FlxG.camera.scroll.x + powerX, FlxG.camera.scroll.y + powerY).then(tweenCameraScroll(0, 0));
	}
	
	private function tweenCameraScroll(toX:Float, toY:Float):FlxTween {
		return FlxTween.tween(FlxG.camera.scroll, { x:toX, y:toY }, Game.settings.SCREEN_SHAKE_DURATION);
	}
	
	private function runFor1Loop(tween:FlxTween) {
		if (tween.executions == 2) {
			tween.cancel();
		}
	}
	
}