package systems.powerups;

import objects.Ball;

class PowerupActivations {
	public var list:Array<Ball->Void>;
	private var clonePowerup:ClonePowerups;
	
	public function new() {
		clonePowerup = new ClonePowerups();
		list = [ clonePowerup.doubleClone, clonePowerup.tripleClone, speedBoost ];
	}
	
	public function speedBoost(ball:Ball) {
		Game.ball.speed.increaseBallSpeed(ball, Settings.powerup.speedBoost);
	}
	
}