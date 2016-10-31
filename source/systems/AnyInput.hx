package systems;

import flixel.FlxG;
import flixel.util.FlxSignal;

class AnyInput {
	private var signal(default, null):FlxSignal;
	
	public function new() {
		signal = new FlxSignal();
	}
	
	public inline function addOnce(listener:Void->Void) {
		signal.addOnce(listener);
	}
	
	public function listen(?listeners:Array<Void->Void>):Bool {
		var inputReceived:Bool;
		if (inputReceived = receivedAny()) {
			addListeners(listeners);
			dispatch();
		}
		return inputReceived;
	}
	
	public inline function receivedAny():Bool {
		return FlxG.mouse.justPressed 
		#if !FLX_NO_KEYBOARD
		|| FlxG.keys.justPressed.ANY
		#end;
	}
	
	private function addListeners(?listeners:Array<Void->Void>) {
		if (listeners == null)
			listeners = [];
		for (listener in listeners)
			addOnce(listener);
	}
	
	private inline function dispatch() {
		signal.dispatch();
	}
}