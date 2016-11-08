package systems;

import flixel.FlxG;
import openfl.display.FPS;

class FramerateCounter {
	public var counter(default, null):FPS;
	public var fps(get, never):Int;
	
	public function new() {
		FlxG.signals.postUpdate.add(checkInputForToggling);
		counter = new FPS(12, -2, 0xFFFFFF);
		FlxG.addChildBelowMouse(counter);
		counter.visible = false;
	}
	
	public function checkInputForToggling() {
		#if android
		if (FlxG.android.justPressed.MENU)
			toggleVisible();
		#end
	}
	
	public function toggleVisible() {
		counter.visible = !counter.visible;
	}
	
	function get_fps():Int {
		return counter.currentFPS;
	}
}