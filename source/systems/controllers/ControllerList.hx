package systems.controllers;

import flixel.FlxG;
import objects.Paddle;
import objects.Wall;
import systems.Signals.Signal;
import systems.ai.SimpleAI;

class ControllerList {
	public static var updateSignal(get, never):Signal;
	public var list(default, null):Array<Controller> = new Array<Controller>();
	
	public function new() {}
	
	public inline function add(controller:Controller) {
		list.push(controller);
		addToSignal(controller);
	}
	
	public function remove(controller:Controller) {
		if (list.remove(controller))
			removeFromSignal(controller);
	}
	
	public function removeAll() {
		for (controller in list)
			removeFromSignal(controller);
		list.splice(0, list.length);
	}
	
	public inline function addNewSimpleAI(?paddle:Paddle, ?goal:Wall) {
		var ai = new SimpleAI(paddle, goal);
		list.push(ai);
		addToSignal(ai);
	}
	
	public function addNewPlayerController(?paddle:Paddle) {
		if (FlxG.onMobile)
			addNewTouch(paddle);
		else addNewKeyboard(paddle);
	}
	
	public inline function addNewKeyboard(?paddle:Paddle) {
		var keyboard = new Keyboard(paddle);
		list.push(keyboard);
		addToSignal(keyboard);
	}
	
	public inline function addNewTouch(?paddle:Paddle) {
		var touch = new Touch(paddle);
		list.push(touch);
		addToSignal(touch);
	}
	
	private function addToSignal(controller:Controller) {
		updateSignal.add(controller.update);
	}
	
	private function removeFromSignal(controller:Controller) {
		updateSignal.remove(controller.update);
	}
	
	static inline function get_updateSignal():Signal {
		return FlxG.signals.preUpdate;
	}
}