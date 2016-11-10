package systems.timers;

import flixel.util.FlxTimer;

class Timers {
	public var roundTimer(default, null):FlxTimer;
	public var pauseTimer(default, null):FlxTimer;
	public var thrillTimer(default, null):FlxTimer;

	public function new() {
		roundTimer = new FlxTimer();
		pauseTimer = new FlxTimer();
		thrillTimer = new FlxTimer();
	}
	
	public inline function stopAll() {
		roundTimer.cancel();
		thrillTimer.cancel();
	}
	
	public function startAll() {
		thrillTimer.start(Settings.duration.thrillLoop, dispatchThrillSignal, 0);
		roundTimer.start(3600);
	}
	
	private function dispatchThrillSignal(timer:FlxTimer) {
		Game.signals.thrill.dispatch();
	}
	
}