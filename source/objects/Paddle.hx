package objects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.tweens.misc.VarTween;
import flixel.util.FlxColor;
import objects.personality.EyePair;
using flixel.util.FlxSpriteUtil;

class Paddle extends FlxSprite {
	public var speed(get, null):Int;
	public var speedBoost(default, null):Int = 0;
	public var startingPosition(default, null):FlxPoint;
	
	public var length(default, set):Int = Settings.unitLength(5);
	public var wrapper(default, null):PaddleWrapper;
	
	public function new(wrapper:PaddleWrapper) {
		super();
		this.wrapper = wrapper;
		startingPosition = FlxPoint.get();
		facing = FlxObject.UP;
	}
	
	override public function destroy():Void {
		startingPosition.put();
		super.destroy();
	}
	
	override public function revive():Void {
		setPosition();
		velocity.set();
		super.revive();
	}
	
	public function resetToStartingPosition() {
		this.setCenter(startingPosition);
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
	
	function get_speed():Int {
		return Game.paddle.speed.globalSpeed + speedBoost;
	}
	
}