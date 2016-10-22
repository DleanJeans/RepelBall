package states;

import flixel.FlxState;

class MainState extends FlxState {
	override public function create():Void {
		#if (debug || testing)
		Game.states.menu();
		#else
		Game.states.splash();
		#end
	}
}