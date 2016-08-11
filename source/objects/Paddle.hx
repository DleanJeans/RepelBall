package objects;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class Paddle extends FlxSprite {
	public var startingPoint:FlxPoint;
	public var length(default, set):Int = Game.unitLength(5);
	public var speed:Int = 500;
	
	public function new() {
		super();
		startingPoint = FlxPoint.get();
		facing = FlxObject.UP;
	}
	
	override public function destroy():Void {
		startingPoint.put();
		super.destroy();
	}
	
	public inline function stop() {
		velocity.set();
	}
	
	public inline function moveLeft() {
		move(FlxPoint.weak(-speed));
	}
	
	public inline function moveRight() {
		move(FlxPoint.weak(speed));
	}
	
	/**
	 * 
	 * @param	distance The distance vector as if facing is FlxObject.UP
	 */
	private function move(distance:FlxPoint) {
		rotateDistanceMatchingFacing(distance);
		velocity.addPoint(distance);
		distance.putWeak();
	}
	
	private function rotateDistanceMatchingFacing(distance:FlxPoint) {
		var facingAngle = FlxAngle.angleFromFacing(facing, true);
		distance.rotate(FlxPoint.weak(), facingAngle + 90);
	}
	
	public inline function movesHorizontally():Bool {
		return facing == FlxObject.UP || facing == FlxObject.DOWN;
	}
	
	public inline function movesVertically():Bool {
		return facing == FlxObject.LEFT || facing == FlxObject.RIGHT;
	}
	
	private function drawPaddle() {
		if (movesHorizontally())
			makeGraphic(length, Game.unitLength(), 0x0);
		else makeGraphic(Game.unitLength(), length, 0x0);
		
		drawRoundRect(0, 0, width, height, Game.unitLength(), Game.unitLength(), FlxColor.WHITE);
	}
	
	function set_length(newLength:Int):Int {
		length = newLength;
		drawPaddle();
		return newLength;
	}
	
	override function set_facing(Direction:Int):Int {
		super.set_facing(Direction);
		drawPaddle();
		return Direction;
	}
	
}