package systems.controllers;

import flixel.FlxG;
import flixel.input.keyboard.FlxKeyList;
import objects.Paddle;

#if !FLX_NO_KEYBOARD
class Keyboard extends Controller {
	public function new(?paddle:Paddle) {
		super(paddle);
	}
	
	override public function update(elapsed:Float):Void {
		if (paddle == null) return;
		
		if (FlxG.keys.anyPressed([A, LEFT]))
			Game.paddle.movement.moveLeft(paddle);
		else if (FlxG.keys.anyPressed([D, RIGHT]))
			Game.paddle.movement.moveRight(paddle);
		else Game.paddle.movement.stop(paddle);
	}
}
#end