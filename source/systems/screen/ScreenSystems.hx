package systems.screen;

class ScreenSystems {
	public var shake(default, null):ScreenShake;
	public var glitch(default, null):ScreenGlitch;

	public function new() {
		shake = new ScreenShake();
		glitch = new ScreenGlitch();
	}
	
}