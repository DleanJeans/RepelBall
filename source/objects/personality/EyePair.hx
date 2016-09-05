package objects.personality;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxPointer;
import flixel.input.touch.FlxTouch;
import flixel.math.FlxMath;
import objects.Ball;
import objects.Paddle;
using flixel.addons.util.position.FlxPosition;

enum Targetting {
	NONE;
	BALL;
	POINTER;
}

class EyePair extends FlxSpriteGroup {
	public var leftEye(default, null):Eye;
	public var rightEye(default, null):Eye;
	public var targetting(default, set):Targetting;
	public var paddle:Paddle;
	public var eyeRangeForPointer:Int = cast FlxG.width / 2;
	public var eyeSeparation:Int = 52;

	public function new() {
		super();
		
		leftEye = new Eye();
		rightEye = new Eye();
		
		add(leftEye);
		add(rightEye);
	}
	
	public function attachToPaddle(paddle:Paddle) {
		this.paddle = paddle;
		
		if (paddle.movesHorizontally()) {
			leftEye.setMidLeft(paddle.getMidLeft());
			rightEye.setMidRight(paddle.getMidRight());
			leftEye.x += leftEye.y;
			rightEye.x -= rightEye.y;
		}
		else {
			leftEye.setMidTop(paddle.getMidTop());
			rightEye.setMidBottom(paddle.getMidBottom());
			leftEye.y += leftEye.x;
			rightEye.y -= rightEye.x;
		}
	}
	
	public function updateFacing() {
		leftEye.facing = rightEye.facing = paddle.facing;
	}
	
	private function resetEyeSeparation() {
		rightEye.setMidLeft(leftEye.getMidRight());
		rightEye.x += eyeSeparation;
	}
	
	override public function update(elapsed:Float):Void {
		look();
		offset.copyFrom(paddle.offset);
		super.update(elapsed);
	}
	
	private function look() {
		if (targetting == null)
			targetting = NONE;
		switch (targetting) {
			case NONE:
				clearTarget();
			case BALL:
				targetNearestBall();
			case POINTER:
				targetPointer();
		}
	}
	
	private function clearTarget() {
		leftEye.clearTarget();
		rightEye.clearTarget();
	}
	
	private function targetNearestBall() {
		var ball = findNearestBall();
		leftEye.ballTarget = ball;
		rightEye.ballTarget = ball;
	}
	
	private function findNearestBall():Ball {
		var nearest:Ball = null;
		var nearestDistance:Float = Math.POSITIVE_INFINITY;
		var distance:Float = 0;
		
		for (ball in Game.level.balls) {
			distance = FlxMath.distanceBetween(paddle, ball);
			if (distance < nearestDistance) {
				nearest = ball;
				nearestDistance = distance;
			}
		}
		
		return nearest;
	}
	
	private function targetPointer() {
		var pointer:FlxPointer;
		var distance:Float;
		#if mobile
		pointer = findNearestTouch();
		distance = FlxMath.distanceToTouch(paddle, cast pointer);
		#else
		pointer = FlxG.mouse;
		distance = FlxMath.distanceToMouse(paddle);
		#end
		if (distance > eyeRangeForPointer)
			pointer = null;
		
		leftEye.pointerTarget = pointer;
		rightEye.pointerTarget = pointer;
	}
	
	private function findNearestTouch():FlxTouch {
		var nearest:FlxTouch = null;
		var nearestDistance:Float = Math.POSITIVE_INFINITY;
		var distance:Float = 0;
		
		for (touch in FlxG.touches.justStarted()) {
			distance = FlxMath.distanceToTouch(paddle, touch);
			if (distance < nearestDistance) {
				nearest = touch;
				nearestDistance = distance;
			}
		}
		
		return nearest;
	}
	
	function set_targetting(newTargetting:Targetting):Targetting {
		if (newTargetting == null)
			newTargetting = NONE;
		return targetting = newTargetting;
	}
	
}