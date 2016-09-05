package systems;

import flixel.FlxG;

class Camera {
	public var spanningDebug(default, null):Bool = false;
	public var spanningSpeed:Int = 2;
	
	public function new() {
		FlxG.signals.preUpdate.add(span);
	}
	
	public function span() {
		#if debug
		if (FlxG.keys.pressed.SPACE) {
			resetCameraScroll();
			spanningDebug = !spanningDebug;
		}
		#end
		
		if (!spanningDebug) return;
		
		if (FlxG.keys.pressed.J)
			FlxG.camera.scroll.x -= spanningSpeed;
		else if (FlxG.keys.pressed.L)
			FlxG.camera.scroll.x += spanningSpeed;
		if (FlxG.keys.pressed.I)
			FlxG.camera.scroll.y -= spanningSpeed;
		else if (FlxG.keys.pressed.K)
			FlxG.camera.scroll.y += spanningSpeed;
	}
	
	private inline function resetCameraScroll() {
		FlxG.camera.scroll.set();
	}
}