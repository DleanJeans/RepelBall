package systems.ball;

class BallSystems {
	public var manager(default, null):BallManager;
	public var shooter(default, null):BallShooter;
	public var pusher(default, null):BallAimer;
	public var fx(default, null):BallEffect;
	public var particles(default, null):BallParticles;
	
	public function new() {
		manager = new BallManager();
		shooter = new BallShooter();
		pusher = new BallAimer();
		fx = new BallEffect();
		particles = new BallParticles();
	}
	
}