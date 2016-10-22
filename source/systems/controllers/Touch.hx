package systems.controllers;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import objects.Paddle;

class Touch extends Controller {
	public function new(?paddle:Paddle) {
		super(paddle);
	}
	
	override public function update(elapsed:Float):Void {
		if (paddle == null) return;
		
		var action:Paddle->Void = null;
		var pointerPosition = FlxG.mouse.getScreenPosition().x;
		var paddleCenter = paddle.getCenterX();
		var difference = pointerPosition - paddleCenter;
		
		if (!FlxG.mouse.pressed)
			action = Game.paddle.movement.stop;
		else if (pass(difference) && difference < 0)
			action = Game.paddle.movement.moveLeft;
		else if (pass(difference) && difference > 0)
			action = Game.paddle.movement.moveRight;
		else action = Game.paddle.movement.stop;
		
		action(paddle);
	}
	
	private function pass(difference:Float, threshold:Float = 10) {
		return Math.abs(difference) >= threshold;
	}
	
}