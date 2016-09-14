package systems.ball;

class BallSystems {
	public var manager(default, null):BallManager;
	public var shooter(default, null):BallShooter;
	public var pusher(default, null):BallAimer;
	
	public function new() {
		manager = new BallManager();
		shooter = new BallShooter();
		pusher = new BallAimer();
	}
	
}