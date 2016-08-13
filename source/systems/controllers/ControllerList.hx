package systems.controllers;

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
	
	public inline function createNewKeyboard(?paddle:Paddle) {
		list.push(new Keyboard(paddle));
	}
}