package systems;

import flixel.FlxG;
import openfl.display.FPS;

class FramerateCounter {
	public var counter(default, null):FPS;
	public var fps(get, never):Int;
	
	public function new() {
		FlxG.signals.postUpdate.add(checkInputForToggling);
	}
	
	public function checkInputForToggling() {
		if (FlxG.keys.justPressed.GRAVEACCENT) {
			if (counter == null) {
				counter = new FPS(12, -2, 0xFFFFFF);
				FlxG.addChildBelowMouse(counter);
			}
			toggleVisible();
		}
	}
	
	public function toggleVisible() {
		counter.visible = !counter.visible;
	}
	
	function get_fps():Int {
		return counter.currentFPS;
	}
}