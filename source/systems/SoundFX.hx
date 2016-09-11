package systems;

import flixel.FlxG;
import flixel.system.FlxAssets;
import flixel.system.FlxSound;
import flixel.system.FlxSoundGroup;
import flixel.tweens.FlxTween;
import objects.Ball;

class SoundFX {
	public var ballHitSounds(default, null):FlxSoundGroup;
	public var theme(default, null):FlxSound;
	
	public function new() {
		loadBallHitSounds();
		loadTheme();
	}
	
	private function loadBallHitSounds() {
		ballHitSounds = new FlxSoundGroup();
		ballHitSounds.add(FlxG.sound.load(FlxAssets.getSound('assets/music/ball-hit'), 1, false, ballHitSounds));
	}
	
	private function loadTheme() {
		theme = FlxG.sound.load(FlxAssets.getSound("assets/music/RhinocerosTheme"), 0, true);
	}
	
	public function playBallHitSound(ball:Ball, object:Dynamic) {
		var random = FlxG.random.int(0, ballHitSounds.sounds.length - 1);
		ballHitSounds.sounds[random].play();
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