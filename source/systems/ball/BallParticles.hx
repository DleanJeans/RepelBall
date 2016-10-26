package systems.ball;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.effects.particles.FlxEmitter;
import flixel.math.FlxPoint;
import objects.Ball;

class BallParticles {
	public var emitter(default, null):FlxEmitter;
	
	private var queue:Array<Ball> = new Array<Ball>();

	public function new() {
		FlxG.signals.preUpdate.add(update);
		
		emitter = new FlxEmitter();
		emitter.makeParticles(16, 16, Game.color.white, 100);
		emitter.solid = false;
		emitter.lifespan.set(0.25, 0.5);
		emitter.speed.set(100, 200);
		emitter.scale.set(1, 1, 1, 1, 0, 0, 0, 0);
		
		Game.stage.addParticle(emitter);
	}
	
	public function update() {
		if (queue.length >= 1)
			emit(queue.shift());
	}
	
	public function emitOnCollision(ball:Ball, object:FlxObject) {
		queue.push(ball);
		if (Std.is(object, Ball))
			queue.push(cast object);
	}
	
	public function emit(ball:Ball) {
		var speed = ball.velocity.distanceTo(FlxPoint.weak());
		var angle = ball.velocity.angleBetween(FlxPoint.weak()) + 90;
		
		emitter.speed.set(speed * 0.25, speed * 0.75);
		emitter.launchAngle.set(angle - 30, angle + 30);
		
		emitter.focusOn(ball);
		emitter.color.set(ball.originalColor);
		emitter.start(true, 0, 5);
	}
	
	public function killAll() {
		emitter.kill();
	}
	
}