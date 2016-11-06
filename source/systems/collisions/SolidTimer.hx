package systems.collisions;

import flixel.FlxObject;
import flixel.util.FlxTimer;

class SolidTimer {
	public var object(default, null):FlxObject;
	private var timer(default, null):FlxTimer;

	public function new(object:FlxObject) {
		this.object = object;
		timer = new FlxTimer();
	}
	
	public function disableFor(seconds:Float = 0.1) {
		object.solid = false;
		timer.start(seconds, resolidify);
	}
	
	private inline function resolidify(timer:FlxTimer) {
		object.solid = true;
	}
	
}