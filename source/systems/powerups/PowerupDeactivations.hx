package systems.powerups;

import objects.Ball;

class PowerupDeactivations {
	public var list:Array<Ball->Void>;
	
	public function new() {
		list = [ deactivateBoost, destroyClone, destroyClone ];
	}
	
	public function destroyClone(ball:Ball) {
		
	}
	
	public function deactivateBoost(ball:Ball) {
		Game.ball.speed.decreaseBallSpeed(ball, Settings.powerup.speedBoost);
	}
	
}