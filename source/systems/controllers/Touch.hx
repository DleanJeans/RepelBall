package systems.controllers;

import flixel.FlxG;
import objects.Paddle;

class Touch extends Controller {
	public function new(?paddle:Paddle) {
		super(paddle);
	}
	
	override public function update() {
		if (!FlxG.mouse.pressed || paddle == null) {
			Game.paddleMovement.stop(paddle);
			return;
		}
		
		var mousePosition = FlxG.mouse.getScreenPosition();
		var halfScreenWidth = FlxG.width / 2;
		
		if (mousePosition.x < halfScreenWidth)
			Game.paddleMovement.moveLeft(paddle);
		else if (mousePosition.x > halfScreenWidth)
			Game.paddleMovement.moveRight(paddle);
		
		mousePosition.put();
	}
	
}