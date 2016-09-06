package states;

import flixel.FlxState;

class MainState extends FlxState {
	override public function create():Void {
		#if mobile
		Game.states.splash();
		#else
		Game.states.menu();
		#end
	}
}