package systems.timers;

import flixel.util.FlxTimer;
import flixel.util.FlxTimer.FlxTimerManager;
import objects.Ball;

class PowerupTimer {
	public var ball(default, null):Ball;
	
	private var timers(default, null):Array<FlxTimer>;
	
	public function new(ball:Ball) {
		this.ball = ball;
		timers = [];
	}
	
	public function start(deactive:Ball->Void) {
		var timer = getTimer();
		timer.start(Settings.powerup.effectDuration, onComplete.bind(deactive));
	}
	
	public function stopAll() {
		for (timer in timers) {
			timer.cancel();
		}
	}
	
	private inline function onComplete(deactive:Ball->Void, timer:FlxTimer) {
		deactive(ball);
	}
	
	private function getTimer():FlxTimer {
		var timer:FlxTimer = null;
		for (t in timers) {
			if (t.finished)
				timer = t;
		}
		if (timer == null) {
			timer = new FlxTimer();
			timers.push(timer);
		}
		return timer;
	}
	
}