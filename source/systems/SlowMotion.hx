package systems;

import flixel.FlxG;

class SlowMotion {
	public function new() {
		#if !FLX_NO_KEYBOARD
		FlxG.signals.preUpdate.add(enableOnShiftKeyPressed);
		#end
	}
	
	public function enableOnShiftKeyPressed() {
		#if !FLX_NO_KEYBOARD
		if (FlxG.keys.pressed.SHIFT)
			Game.speed.slowMo = Settings.SLOW_MO_TIME_SCALE;
		else Game.speed.slowMo = 1;
		#end
	}
}