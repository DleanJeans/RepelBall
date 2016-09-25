package systems.paddle;

import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import objects.Ball;
import objects.Paddle;
import systems.CompositePoint;

typedef TweenMap = Map<Paddle, HoveringTween>;

class PaddleHoverer {
	public var tweenMap(default, null):TweenMap;
	
	public function new() {
		tweenMap = new TweenMap();
	}
	
	public function startHoveringAllPaddles() {
		for (paddle in Game.level.paddles)
			startHovering(paddle, Game.unitLength(0.5));
	}
	
	public function stopHoveringAllPaddles() {
		for (paddle in Game.level.paddles)
			stopHovering(paddle);
	}
	
	public function pauseAllHovering() {
		for (hoveringTween in tweenMap)
			hoveringTween.hoveringTween.active = false;
	}
	
	public function resumeAllHovering() { 
		for (hoveringTween in tweenMap)
			hoveringTween.hoveringTween.active = true;
	}
	
	public function knockBackBallSpeed(ball:Ball, paddle:Paddle) {
		var ballVelocity = paddle.get1Axis(ball.velocity, false);
		var range = ballVelocity / Game.unitLength(2.5);
		knockBack(paddle, range);
	}
	
	public function knockBack(paddle:Paddle, range:Float = Game.unitLength(1)) {
		var hoveringTween = tweenMap.get(paddle);
		hoveringTween.knockBack(range);
	}
	
	public function startHovering(paddle:Paddle, range:Float = Game.unitLength(0.5)) {
		var hoveringTween = new HoveringTween(paddle);
		hoveringTween.startTween(range);
		tweenMap.set(paddle, hoveringTween);
	}
	
	public function stopHovering(paddle:Paddle, resetPosition:Bool = false) {
		var tween:HoveringTween = tweenMap.get(paddle);
		if (tween != null) {
			tween.hoveringTween.cancel();
			tween.hoveringOffset.set();
			tweenMap.remove(paddle);
			paddle.offset.set();
			if (resetPosition)
				paddle.resetToStartingPosition();
		}
	}
}

class HoveringTween {
	public var hoveringTween(default, null):FlxTween;
	public var knockBackTween(default, null):FlxTween;
	public var offset(default, null):CompositePoint;
	public var hoveringOffset(get, never):FlxPoint;
	public var knockBackOffset(get, never):FlxPoint;
	
	public var paddle:Paddle;
	
	public function new(paddle:Paddle) {
		this.paddle = paddle;
		offset = new CompositePoint();
	}
	
	public function destroy() {
		offset.destroy();
	}
	
	public inline function copyOffset() {
		if (paddle != null)
			offset.sum().copyTo(paddle.offset);
	}
	
	public function startTween(range:Float) {
		var down = downVector(range);
		
		hoveringOffset.set(-down.x / 2, -down.y / 2);
		hoveringTween = Game.tween.hovering(hoveringOffset, down, updateOffset);
	}
	
	private inline function downVector(range:Float):FlxPoint {
		return FlxPoint.get(range).rotate(FlxPoint.weak(), FlxAngle.angleFromFacing(paddle.facing, true)).round();
	}
	
	private inline function updateOffset(tween:FlxTween) {
		copyOffset();
	}
	
	public function knockBack(range:Float) {
		range = Math.abs(range);
		var down = downVector(range);
		
		stopKnockbackTween();
		knockBackTween = Game.tween.knockBack(knockBackOffset, down);
	}
	
	private function stopKnockbackTween() {
		if (knockBackTween != null && !knockBackTween.finished)
			knockBackTween.cancel();
	}
	
	inline function get_hoveringOffset():FlxPoint {
		return offset.getPoint("hovering");
	}
	
	inline function get_knockBackOffset():FlxPoint {
		return offset.getPoint("knockBack");
	}
}