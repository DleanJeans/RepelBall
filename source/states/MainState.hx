package states;
import flixel.FlxState;

class MainState extends FlxState {
	override public function create():Void {
		Game.states.menu();
	}
}