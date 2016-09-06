package objects.personality;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxPointer;
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
			#if !mobile
			case POINTER:
				targetPointer();
			#end
			default:
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
		var pointer:FlxPointer = FlxG.mouse;
		var distance = FlxMath.distanceToMouse(paddle);
		if (distance > eyeRangeForPointer)
			pointer = null;
		
		leftEye.pointerTarget = pointer;
		rightEye.pointerTarget = pointer;
	}
	
	function set_targetting(newTargetting:Targetting):Targetting {
		if (newTargetting == null)
			newTargetting = NONE;
		return targetting = newTargetting;
	}
	
}