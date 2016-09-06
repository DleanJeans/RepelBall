package systems.controllers;

import flixel.FlxG;
import flixel.math.FlxPoint;
import objects.Paddle;

class Touch extends Controller {
	public function new(?paddle:Paddle) {
		super(paddle);
	}
	
	override public function update(elapsed:Float):Void {
		if (paddle == null) return;
		
		var action:Paddle->Void = null;
		var pointerPosition:FlxPoint = null;
		
		pointerPosition = FlxG.mouse.getScreenPosition();
		
		if (!FlxG.mouse.pressed)
			action = Game.paddleMovement.stop;
		else if (pointerPosition.x < FlxG.width / 2)
			action = Game.paddleMovement.moveLeft;
		else if (pointerPosition.x > FlxG.width / 2)
			action = Game.paddleMovement.moveRight;
		else action = Game.paddleMovement.stop;
		
		action(paddle);
		pointerPosition.put();
	}
	
}