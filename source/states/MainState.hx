package states;

import flixel.FlxState;
import test.TestState;

class MainState extends FlxState {
	override public function create():Void {
		openSubState(new TestState());
	}
}