package systems.powerups;
import flixel.tweens.FlxTween;
import objects.Ball;
import objects.Powerup;

class PowerupManager {

	public function new() {}
	
	public function activate(ball:Ball, powerup:Powerup) {
		powerup.activate(ball);
		ball.startPowerupTimer(powerup.deactivate);
	}
	
	public function popOut(ball:Ball, powerup:Powerup) {
		powerup.popOutThenKill();
	}
	
	public function glitch(ball:Ball, powerup:Powerup) {
		Game.screen.glitch.run();
	}
	
	public function stopHoveringAll() {
		Game.stage.powerups.forEach(stopHovering);
	}
	
	public function stopHovering(powerup:Powerup) {
		Game.tween.stopTween(powerup.scaleTween);
	}
	
}