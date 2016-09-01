package objects;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
using flixel.addons.util.position.FlxPosition;

class Paddle extends FlxSprite {
	public var startingPoint(default, null):FlxPoint;
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
	
	public function resetPosition() {
		this.setCenter(startingPoint);
	}
	
	public function get1Axis(point:FlxPoint, parallel:Bool = true):Float {
		var axis =
		if (parallel == movesHorizontally())
			point.x;
		else point.y;
		point.putWeak();
		return axis;
	}
	
	public inline function movesHorizontally():Bool {
		return facing == FlxObject.UP || facing == FlxObject.DOWN;
	}
	
	public inline function movesVertically():Bool {
		return facing == FlxObject.LEFT || facing == FlxObject.RIGHT;
	}
	
	private inline function drawPaddle() {
		Game.renderer.drawPaddle(this);
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