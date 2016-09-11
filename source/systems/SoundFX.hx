package systems;

import flixel.FlxG;
import flixel.system.FlxAssets;
import flixel.system.FlxSound;
import flixel.system.FlxSoundGroup;
import flixel.tweens.FlxTween;
import objects.Ball;

class SoundFX {
	public var theme(default, null):FlxSound;
	
	public function new() {
		loadTheme();
	}
	
	private function loadTheme() {
		theme = FlxG.sound.load(FlxAssets.getSound("assets/music/RhinocerosTheme"), 0, true);
	}
	
	public function playBallHitSound(ball:Ball, object:Dynamic) {
		FlxG.sound.play(FlxAssets.getSound('assets/music/ball-hit'));
	}
	
	public function fadeInTheme() {
		theme.play();
		theme.fadeIn(3);
	}
	
	public function fadeOutTheme() {
		theme.fadeOut(1, 0, stopTheme);
	}
	
	private function stopTheme(tween:FlxTween) {
		theme.stop();
	}
}