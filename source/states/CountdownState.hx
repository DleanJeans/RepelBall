package states;

import flixel.FlxSubState;
import flixel.addons.util.position.FlxText;
import flixel.util.FlxTimer;

class CountdownState extends FlxSubState {
	private var text:FlxText;
	private var timer:FlxTimer;
	
	override public function create():Void {
		text = new FlxText(0, 0, 0, "3", 50);
		text.screenCenter();
		add(text);
		
		timer = new FlxTimer().start(3, startRound);
	}
	
	private function startRound(timer:FlxTimer) {
		Game.signals.roundStart.dispatch();
		close();
	}
	
	override public function update(elapsed:Float):Void {
		updateText();
		super.update(elapsed);
	}
	
	private function updateText() {
		var timeLeft:Int = Math.round(timer.timeLeft);
		text.text = Std.string(timeLeft);
		if (timeLeft == 0)
			text.text = "GO!";
		text.screenCenter();
	}
}