package systems;

import flixel.FlxG;
import flixel.math.FlxMath;
import objects.Ball;

class Speed {
	public var slowMo(default, null):Float = 1;
	public var auto(default, null):Float = 1;
	public var pauseScale(default, null):Float = 1;
	
	public var slowMoEnabled(get, never):Bool; function get_slowMoEnabled() return slowMo < 1;
	
	public function new() {
		FlxG.signals.preUpdate.add(update);
	}
	
	public function update() {
		var fps = Game.framerateCounter.fps;
		auto = FlxG.drawFramerate / fps;
		auto = FlxMath.bound(auto, 1, 2);
		pauseScale = slowMo == 1 ? pauseScale : 1;
		
		FlxG.timeScale = auto * slowMo * pauseScale;
	}
	
	public inline function toggleSlowMo() {
		#if testing
		Game.speed.slowMo = Game.speed.slowMo == 1 ? Settings.timeScale.slowMo: 1;
		#end
	}
	
	public inline function pauseOnBallCollision(ball:Ball, object:Dynamic) {
		pause();
	}
	
	public function pause() {
		pauseScale = Settings.timeScale.pause;
		
		Game.timers.pauseTimer.start(Settings.duration.pause, function(_) pauseScale = 1);
	}
	
}