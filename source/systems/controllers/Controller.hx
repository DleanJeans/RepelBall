package systems.controllers;

import flixel.FlxG;
import flixel.util.FlxSignal;
import objects.Paddle;

class Controller {
	private static var updateSignal(get, null):FlxSignal;
	
	public var paddle:Paddle;
	public var autoUpdate(get, set):Bool;
	
	public function new(?paddle:Paddle) {
		this.paddle = paddle;
		autoUpdate = true;
	}
	
	public function destroy() {
		autoUpdate = false;
		paddle = null;
	}
	
	/**
	 * Note: Rememeber to null check `paddle`
	 */
	public function update() {
		if (paddle == null) return;
	}
	
	static inline function get_updateSignal():FlxSignal {
		return FlxG.signals.preUpdate;
	}
	
	inline function get_autoUpdate():Bool {
		return updateSignal.has(update);
	}
	
	function set_autoUpdate(newAutoUpdate:Bool):Bool {
		if (newAutoUpdate)
			updateSignal.add(update);
		else updateSignal.remove(update);
		return newAutoUpdate;
	}
	
}