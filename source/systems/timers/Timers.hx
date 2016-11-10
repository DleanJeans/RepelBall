package systems.timers;

import flixel.util.FlxTimer;

class Timers {
	public var roundTimer(default, null):FlxTimer;
	public var pauseTimer(default, null):FlxTimer;

	public function new() {
		roundTimer = new FlxTimer();
		pauseTimer = new FlxTimer();
	}
	
	public function stopRoundTimer() {
		roundTimer.cancel();
	}
	
}