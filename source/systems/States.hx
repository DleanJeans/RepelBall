package systems;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSubState;
import states.CountdownState;
import states.GoalState;
import states.MenuState;
import states.PlayState;
import states.SplashState;
import states.WarningState;
import states.WinState;

class States {
	public var mainState(default, null):FlxState = FlxG.state;
	public var state(default, null):FlxSubState;
	public var subState(default, null):FlxSubState;
	
	public function new() {}
	
	public inline function resumeState() {
		state.persistentUpdate = true;
	}
	
	public inline function pauseState() {
		state.persistentUpdate = false;
	}
	
	public inline function splash() {
		mainState.openSubState(state = new SplashState());
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
	
	public inline function win() {
		state.openSubState(subState = new WinState());
	}
	
}