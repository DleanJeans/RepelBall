package systems.controllers;

import flixel.FlxBasic;
import flixel.FlxG;
import objects.Paddle;

class Controller extends FlxBasic {
	public var paddle:Paddle;
	
	public function new(?paddle:Paddle) {
		super();
		this.paddle = paddle;
	}
	
	/**
	 * Note: Rememeber to null check `paddle`
	 * if (paddle == null) return;
	 */
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
	
	override public function kill():Void {
		super.kill();
		Game.paddle.movement.stop(paddle);
	}
	
}