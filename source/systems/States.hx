package systems;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSubState;
import states.CountdownState;
import states.GoalState;
import states.MenuState;
import states.PlayState;
import states.WarningState;

class States {
	public var mainState(default, null):FlxState = FlxG.state;
	public var state(default, null):FlxSubState;
	public var subState(default, null):FlxSubState;
	
	public function new() {}
	
	public inline function closeOnAnyInput(state:FlxSubState, ?callback:Void->Void) {
		if (FlxG.mouse.justPressed || FlxG.keys.justPressed.ANY) {
			state.close();
			if (callback != null)
				callback();
		}
	}
	
	public inline function resumeState() {
		state.persistentUpdate = true;
	}
	
	public inline function pauseState() {
		state.persistentUpdate = false;
	}
	
	public inline function menu() {
		mainState.openSubState(state = new MenuState());
	}
	
	public inline function play() {
		mainState.openSubState(state = new PlayState());
	}
	
	public inline function goal() {
		state.openSubState(subState = new GoalState());
	}
	
	public inline function countdown() {
		state.openSubState(subState = new CountdownState());
	}
	
	public inline function warning() {
		state.openSubState(subState = new WarningState());
	}
	
}