package systems.trail;
import flixel.util.FlxColor;
import objects.Ball;
import objects.Paddle;

class CometTrailWrapper {
	public var trail(default, null):CometTrail;
	
	public function new() {
		trail = new CometTrail();
		Game.level.addParticle(trail);
	}
	
	public inline function enable() {
		trail.active = true;
		trail.visible = true;
	}
	
	public inline function disable() {
		trail.active = false;
		trail.visible = false;
	}
	
	public function removeAll() {
		trail.removeAll();
	}
	
	public inline function addBall(ball:Ball) {
		trail.add(ball);
	}
	
	public function updateTrailColor(ball:Ball, object:Dynamic) {
		var trail = trail.getTrail(ball);
		var newColor = Std.is(object, Paddle) ? paddleToTrailColor(object) : trail.color;
		Game.tween.trailColor(trail, newColor);
	}
	
	private inline function paddleToTrailColor(paddle:Paddle):FlxColor {
		var color = paddle.color;
		color.alphaFloat = 0.5;
		return color;
	}
	
}