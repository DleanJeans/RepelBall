package systems.powerups;

import objects.Ball;

class PowerupActivations {
	public var list:Array<Ball->Void>;
	private var clonePowerup:ClonePowerups;
	
	public function new() {
		clonePowerup = new ClonePowerups();
		list = [ speedBoost, clonePowerup.doubleClone, clonePowerup.tripleClone ];
	}
	
	public function speedBoost(ball:Ball) {
		Game.ball.speed.increaseBallSpeed(ball, Settings.powerup.speedBoost);
	}
	
}