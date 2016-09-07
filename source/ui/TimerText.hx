package ui;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class TimerText extends FlxText {
	public var timer:FlxTimer;
	
	public function new() {
		super(0, 0, 0, "0.000", 40);
		color = Game.color.red;
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		updateText();
	}
	
	public function updateText() {
		if (timer != null) {
			var timeLeft = timer.timeLeft - 0.4;
			
			if (timeLeft < 0)
				text = Game.messages._0_000;
			else text = roundTimeLeft(timeLeft);
			
		}
		else text =
		#if debug
		"No timer!";
		#else
		"";
		#end
	}
	
	private function roundTimeLeft(timeLeft:Float) {
		var timeLeft = FlxMath.roundDecimal(timeLeft, 3);
		var timeLeftString = Std.string(timeLeft);
		
		while (timeLeftString.length < Game.messages._0_000.length) {
			if (timeLeftString.length == 1)
				timeLeftString += ".";
			timeLeftString += "0";
		}
		return timeLeftString;
	}
	
}