package systems;

import flixel.FlxG;
import states.CountdownState;
import states.GoalState;
import states.MenuState;
import states.PlayState;

class States {
	public function new() {}
	
	public inline function menu() {
		FlxG.switchState(new MenuState());
	}
	
	public inline function play() {
		FlxG.switchState(new PlayState());
	}
	
	public inline function goal() {
		FlxG.state.openSubState(new GoalState());
	}
	
	public inline function countdown() {
		FlxG.state.openSubState(new CountdownState());
	}
	
}