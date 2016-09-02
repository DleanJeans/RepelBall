package systems.collisions;
import flixel.FlxG;
import flixel.util.FlxSpriteUtil;

class BallBounder {
	public function new() {
		FlxG.signals.preUpdate.add(update);
	}
	
	public function update() {
		for (ball in Game.level.balls)
			FlxSpriteUtil.bound(ball);
	}
}