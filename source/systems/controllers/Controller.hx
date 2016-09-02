package systems.controllers;

import flixel.FlxG;
import flixel.util.FlxSignal;
import objects.Paddle;

class Controller {
	public var paddle:Paddle;
	
	public function new(?paddle:Paddle) {
		this.paddle = paddle;
	}
	
	/**
	 * Note: Rememeber to null check `paddle`
	 */
	public function update() {
		if (paddle == null) return;
	}
	
}