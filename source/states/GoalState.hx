package states;

import flixel.FlxSubState;
import flixel.util.FlxColor;

class GoalState extends FlxSubState {
	override public function create():Void {
		bgColor = 0x0;
		add(Game.goalText);
	}
	
	override public function destroy():Void {
		remove(Game.goalText);
		super.destroy();
	}
	
}