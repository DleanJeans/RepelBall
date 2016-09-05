package objects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import objects.personality.Face;
using flixel.addons.util.position.FlxPosition;

class PaddleWrapper extends FlxSpriteGroup {
	public var paddle(default, null):Paddle;
	public var face(default, null):Face;

	public function new() {
		super();
		
		facing = FlxObject.UP;
		
		paddle = new Paddle();
		face = new Face(paddle);
		
		paddle.wrapper = this;
		
		add(paddle);
		add(face);
	}
	
	public inline function reattachFace() {
		face.reattachToPaddle();
	}
	
	override function set_color(newColor:FlxColor):FlxColor {
		return paddle.color = newColor;
	}
	
}