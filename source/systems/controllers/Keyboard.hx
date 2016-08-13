package systems.controllers;

import flixel.FlxG;
import flixel.input.keyboard.FlxKeyList;
import objects.Paddle;

class Keyboard extends Controller {
	public function new(?paddle:Paddle) {
		super(paddle);
	}
	
	override public function update() {
		if (paddle == null) return;
		
		if (FlxG.keys.anyPressed([A, LEFT]))
			Game.paddleMovement.moveLeft(paddle);
		else if (FlxG.keys.anyPressed([D, RIGHT]))
			Game.paddleMovement.moveRight(paddle);
		else Game.paddleMovement.stop(paddle);
	}
}