package systems;

import flixel.FlxG;
import flixel.system.FlxAssets;
import objects.Ball;

class SFX {
	public function new() {
		FlxG.signals.gameStarted.add(playMusic);
	}
	
	public function playBallHitSound(ball:Ball, object:Dynamic) {
		FlxG.sound.play(FlxAssets.getSound("assets/music/ball-hit"));
	}
	
	public function playMusic() {
		FlxG.sound.playMusic(FlxAssets.getSound("assets/music/theme"));
	}
}