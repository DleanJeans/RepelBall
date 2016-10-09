package systems.paddle;

import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import objects.Paddle;
import objects.PaddleWrapper;
import objects.Wall;
import objects.personality.EyePair;
import objects.personality.Face;
import objects.personality.Mouth;

class PaddleExpression {
	public function new() {}
	
	public function reattachFace(paddle:Paddle, wall:Wall) {
		paddle.wrapper.reattachFace();
	}
	
	public function closeAll() {
		for (face in Game.level.faces)
			face.mouth.close();
	}
	
	public function updateEyesFacing() {
		for (face in Game.level.faces)
			face.eyes.updateFacing();
	}
	
	public function tweenUpdateEyeSeparation(paddle:Paddle, tween:FlxTween) {
		updateEyeSeparation(paddle);
	}
	
	public inline function updateEyeSeparation(paddle:Paddle) {
		eyes(paddle).scaleEyeSeparation(wrapper(paddle).scale.x);
	}
	
	public inline function smile(paddle:Paddle) {
		mouth(paddle).smile();
	}
	
	public inline function frown(paddle:Paddle) {
		mouth(paddle).frown();
	}
	
	public inline function shut(paddle:Paddle) {
		mouth(paddle).close();
	}
	
	public inline function lookAtBall(paddle:Paddle) {
		eyes(paddle).targetting = BALL;
	}
	
	public inline function lookAtPointer(paddle:Paddle) {
		eyes(paddle).targetting = POINTER;
	}
	
	public inline function oohWhenColorChanged(paddle:Paddle) {
		mouth(paddle).ooh();
		eyes(paddle).targetting = NONE;
		new FlxTimer().start(Game.settings.COLOR_CHANGING_TWEEN_DURATION, resetFromOoh.bind(paddle));
	}
	
	public inline function resetFromOoh(paddle:Paddle, timer:FlxTimer) {
		smile(paddle);
		lookAtPointer(paddle);
	}
	
	public inline function wrapper(paddle:Paddle):PaddleWrapper return paddle.wrapper;
	public inline function face(paddle:Paddle):Face return paddle.wrapper.face;
	public inline function eyes(paddle:Paddle):EyePair return paddle.wrapper.face.eyes;
	public inline function mouth(paddle:Paddle):Mouth return paddle.wrapper.face.mouth;
	
}