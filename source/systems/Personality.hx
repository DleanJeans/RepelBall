package systems;

import objects.Paddle;
import objects.Wall;

class Personality {
	public function new() {}
	
	public function reattachFace(paddle:Paddle, wall:Wall) {
		paddle.wrapper.reattachFace();
	}
	
	public function updateFacing() {
		for (face in Game.level.faces)
			face.eyes.updateFacing();
	}
}