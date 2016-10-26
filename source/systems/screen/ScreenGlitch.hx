package systems.screen;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class ScreenGlitch  {
	private var _timer:FlxTimer;
	
	public function new() {
		_timer = new FlxTimer();
	}
	
	public function run() {
		Game.states.state.bgColor = randomSolidColor();
		runTimer();
	}
	
	private function runTimer() {
		_timer.start(Settings.GLITCH_DURATION, resetBackgroundColor);
	}
	
	private function resetBackgroundColor(timer:FlxTimer) {
		Game.states.state.bgColor = Game.color.background;
	}
	
	private inline function randomSolidColor():FlxColor {
		return FlxG.random.color(null, null, 255);
	}
}