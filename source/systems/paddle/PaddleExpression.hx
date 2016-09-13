package systems.paddle;

import flixel.util.FlxTimer;
import objects.Paddle;
import objects.personality.EyePair;

class PaddleExpression {
	public function new() {}
	
	public inline function smile(paddle:Paddle) {
		var face = paddle.wrapper.face;
		face.mouth.smile();
	}
	
	public inline function frown(paddle:Paddle) {
		var face = paddle.wrapper.face;
		face.mouth.frown();
	}
	
	public inline function shut(paddle:Paddle) {
		var face = paddle.wrapper.face;
		face.mouth.shut();
	}
	
	public inline function lookAtBall(paddle:Paddle) {
		var face = paddle.wrapper.face;
		face.eyes.targetting = BALL;
	}
	
	public inline function lookAtPointer(paddle:Paddle) {
		var face = paddle.wrapper.face;
		face.eyes.targetting = POINTER;
	}
	
	public inline function oohWhenColorChanged(paddle:Paddle) {
		var face = paddle.wrapper.face;
		face.mouth.ooh();
		face.eyes.targetting = NONE;
		new FlxTimer().start(Game.settings.COLOR_CHANGED_TWEEN_DURATION, resetFromOoh.bind(paddle));
	}
	
	public inline function resetFromOoh(paddle:Paddle, timer:FlxTimer) {
		shut(paddle);
		lookAtPointer(paddle);
	}
	
}