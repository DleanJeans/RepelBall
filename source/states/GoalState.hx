package states;

import flixel.FlxSubState;
import flixel.addons.util.position.FlxText;
import flixel.util.FlxColor;

class GoalState extends FlxSubState {
	private var text:FlxText;
	
	override public function create():Void {
		text = new FlxText(0, 0, 0, "GOAL!", 50);
		text.screenCenter();
		add(text);
	}
	
}