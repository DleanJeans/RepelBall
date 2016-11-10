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
	public var kidsCheering(default, null):FlxSound;
	public var ballSoundMap(default, null):BallSoundMap;
	
	public function new() {
		loadTheme();
		loadKidsCheering();
		ballSoundMap = new BallSoundMap();
	}
	
	private function loadTheme() {
		theme = FlxG.sound.load(getSound(AssetPaths.theme__mp3), 0, true);
	}
	
	private function loadKidsCheering() {
		kidsCheering = FlxG.sound.load(getSound(AssetPaths.kids_cheering__mp3));
	}
	
	public function playBallHitSound(ball:Ball, object:Dynamic) {
		var sound = ballSoundMap[ball];
		if (sound == null)
			sound = FlxG.sound.load(getSound(AssetPaths.ball_hit__mp3));
		ballSoundMap[ball] = sound;
		sound.play();
	}
	
	public function playKidsCheering() {
		kidsCheering.play();
	}
	
	public function playThemeInMenu() {
		theme.play();
		theme.fadeIn(3);
	}
	
	public function playThemeInGame() {
		theme.play();
		theme.fadeIn(3, 0, 0.8);
	}
	
	public function fadeOutTheme() {
		theme.play();
		theme.fadeOut(1, 0.05);
	}
	
	private inline function getSound(path:String) {
		return FlxAssets.getSound(path.split(".")[0]);
	}
	
}