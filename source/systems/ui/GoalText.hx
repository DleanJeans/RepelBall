package systems.ui;

import flixel.text.FlxText;

class GoalText extends FlxText {

	public function new() {
		super(0, 0, 0, "GOAL!", 50);
		screenCenter();
	}
	
}