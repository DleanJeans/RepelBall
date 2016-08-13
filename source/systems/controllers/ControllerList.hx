package systems.controllers;

import flixel.FlxG;
import objects.Paddle;

class ControllerList {
	public var list(default, null):Array<Controller> = new Array<Controller>();
	
	public function new() {}
	
	public inline function add(controller:Controller) {
		list.push(controller);
	}
	
	public function remove(controller:Controller) {
		if (list.remove(controller))
			controller.destroy();
	}
	
	public function removeAll() {
		for (controller in list)
			remove(controller);
	}
	
	public function addNewPlayerController(?paddle:Paddle) {
		if (FlxG.onMobile)
			addNewTouch(paddle);
		else addNewKeyboard(paddle);
	}
	
	public inline function addNewKeyboard(?paddle:Paddle) {
		list.push(new Keyboard(paddle));
	}
	
	public inline function addNewTouch(?paddle:Paddle) {
		list.push(new Touch(paddle));
	}
}