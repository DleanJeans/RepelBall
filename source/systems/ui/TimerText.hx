package systems.ui;

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
				text = "0.000";
			else text = Std.string(FlxMath.roundDecimal(timeLeft, 3));
			
		}
		else text =
		#if debug
		"No timer!";
		#else
		"";
		#end
	}
	
}