package states;

import flixel.FlxState;
import states.test.TestState;

class MainState extends FlxState {
	override public function create():Void {
		openSubState(new TestState());
	}
}