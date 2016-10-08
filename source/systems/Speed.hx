package systems;
import flixel.FlxG;

class Speed {
	public var slowMo:Float = 1;
	public var auto:Float = 1;
	
	public function new() {
		FlxG.signals.preUpdate.add(update);
	}
	
	public function update() {
		var fps = Game.framerateCounter.fps;
		if (fps >= 25)
			auto = FlxG.drawFramerate / fps;
		if (auto < 1)
			auto = 1;
		
		FlxG.timeScale = auto * slowMo;
	}
	
}