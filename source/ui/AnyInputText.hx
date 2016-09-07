package ui;

import flixel.FlxG;
import flixel.text.FlxText;

class AnyInputText extends FlxText {
	public function new() {
		super(0, 0, FlxG.width * 0.85, "", 30);
		alignment = FlxTextAlign.CENTER;
		text = Game.messages.askForAnyInput;
		screenCenter();
		y = FlxG.height - 200;
	}
	
}