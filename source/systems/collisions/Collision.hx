package systems.collisions;

import flixel.FlxG;

class Collision {
	public var detector(default, null):Detector;
	public var handler(default, null):Handler;
	
	public function new() {
		detector = new Detector();
		handler = new Handler();
	}
	
}