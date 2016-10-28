package systems;

import flixel.FlxG;
import flixel.math.FlxMath;

class Speed {
	public var slowMo:Float = 1;
	public var auto:Float = 1;
	
	public function new() {
		FlxG.signals.preUpdate.add(update);
	}
	
	public function update() {
		var fps = Game.framerateCounter.fps;
		auto = FlxG.drawFramerate / fps;
		auto = FlxMath.bound(auto, 1, 2);
		
		FlxG.timeScale = auto * slowMo;
	}
	
	public function toggleSlowMo() {
		#if !FLX_NO_KEYBOARD
		Game.speed.slowMo = Game.speed.slowMo == 1 ? Settings.SLOW_MO_TIME_SCALE: 1;
		#end
	}
	
}