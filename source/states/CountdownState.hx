package states;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class CountdownState extends FlxSubState {
	public var text(default, null):FlxText;
	public var timer(default, null):FlxTimer;
	
	override public function create():Void {
		text = new FlxText(0, 0, 0, "3", 100);
		text.screenCenter();
		add(text);
		
		timer = new FlxTimer().start(Settings.duration.preRoundCountdown, startRound);
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