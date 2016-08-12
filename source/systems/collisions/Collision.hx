package systems.collisions;

class Collision {
	public var detector:Detector;
	public var handler:Handler;
	
	public function new() {
		detector = new Detector();
		handler = new Handler();
	}
	
}