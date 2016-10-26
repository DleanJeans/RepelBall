package systems.ball;

import flixel.FlxObject;
import flixel.effects.particles.FlxEmitter;
import flixel.math.FlxPoint;
import objects.Ball;

class BallParticles {
	public var emitter(default, null):FlxEmitter;

	public function new() {
		emitter = new FlxEmitter();
		emitter.solid = false;
		emitter.makeParticles(16, 16, Game.color.white);
		emitter.lifespan.set(0.25, 0.5);
		emitter.speed.set(100, 200);
		emitter.scale.set(1, 1, 1, 1, 0, 0, 0, 0);
		
		Game.stage.addParticle(emitter);
	}
	
	public function emit(ball:Ball, object:FlxObject) {
		var speed = ball.velocity.distanceTo(FlxPoint.weak());
		var angle = ball.velocity.angleBetween(FlxPoint.weak()) + 90;
		
		emitter.speed.set(speed * 0.25, speed * 0.75);
		emitter.launchAngle.set(angle - 30, angle + 30);
		
		emitter.setPosition(ball.getCenterX(), ball.getCenterY());
		emitter.color.set(ball.originalColor);
		emitter.start(true, 0, 5);
	}
	
}