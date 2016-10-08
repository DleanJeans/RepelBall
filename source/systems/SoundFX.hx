package systems;

import flixel.FlxG;
import flixel.system.FlxAssets;
import flixel.system.FlxSound;
import flixel.system.FlxSoundGroup;
import flixel.tweens.FlxTween;
import objects.Ball;

typedef BallSoundMap = Map<Ball, FlxSound>;

class SoundFX {
	public var theme(default, null):FlxSound;
	public var ballSoundMap:BallSoundMap;
	
	public function new() {
		loadTheme();
		ballSoundMap = new BallSoundMap();
	}
	
	private function loadTheme() {
		theme = FlxG.sound.load(FlxAssets.getSound("assets/music/RhinocerosTheme"), 0, true);
		theme.loopTime = 45 * 1000;
	}
	
	public function playBallHitSound(ball:Ball, object:Dynamic) {
		var sound = ballSoundMap[ball];
		if (sound == null)
			sound = FlxG.sound.load(FlxAssets.getSound('assets/music/ball-hit'));
		sound.play();
	}
	
	public function playThemeInMenu() {
		theme.play(true);
		theme.fadeIn(3);
	}
	
	public function playThemeInGame() {
		theme.play(true, theme.loopTime);
		theme.fadeIn(3, 0, 0.5);
	}
	
	public function fadeOutTheme() {
		theme.fadeOut(1, 0.1);
	}
	
}