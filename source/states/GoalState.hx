package states;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class GoalState extends FlxSubState {
	private var text:FlxText;
	
	override public function create():Void {
		text = new FlxText(0, 0, 0, "GOAL!", 100);
		text.font = AssetPaths.SquareFont__ttf;
		text.screenCenter();
		add(text);
	}
	
}