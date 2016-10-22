package systems.powerups;
import flixel.tweens.FlxTween;
import objects.Ball;
import objects.Powerup;

class PowerupManager {

	public function new() {}
	
	public function activate(ball:Ball, powerup:Powerup) {
		powerup.activate(ball);
	}
	
	public function popOut(ball:Ball, powerup:Powerup) {
		powerup.popOutThenKill();
	}
	
	public function glitch(ball:Ball, powerup:Powerup) {
		Game.screen.glitch.run();
	}
	
}